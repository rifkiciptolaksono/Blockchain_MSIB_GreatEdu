const crypto = require("crypto"),
    SHA256 = message => crypto.createHash("sha256").update(message).digest("hex");

class block {
    constructor(times = "", data = []) {
        this.times = times;
        this.data = data;
        this.hash = this.getHash();
        this.prevHash = "";
        this.nonce = 0;

    }
    getHash() {
        return SHA256(JSON.stringify(this.data) + this.times + this.prevHash + this.nonce);
    }
    mine(difficuly) {
        while (this.hash.startsWith(Array(difficuly + 1).join("0"))); {
            this.nonce++;
            this.hash = this.getHash();
        }

    }
}

class Blockchain {
    constructor() {
        this.Chain = [new block(Date.now().toString())];
        this.difficuly = 1;
        this.blockTime = 30000;
    }

    getLastBlock() {
        return this.Chain[this.Chain.length - 1];

    }


    addBlock(block) {
        block.prevHash = this.getLastBlock().hash;
        block.hash = block.getHash();
        block.mine(this.difficuly);

        this.difficuly += Date.now() - parseInt(this.getLastBlock().times) < this.blockTime ? 1 : -1;
        this.Chain.push(block);
    }
    isValid(blockchain = this) {
        for (let i = 1; i < blockchain.Chain.length; i++) {
            const currentBlock = blockchain.Chain[i];
            const prevBlock = blockchain.Chain[i - 1];

            if (currentBlock.hash !== currentBlock.getHash() || currentBlock.prevHash !== prevBlock.hash) {
                return false;
            }
        }
        return true;
    }
}

const baru = new Blockchain();
baru.addBlock(new block(Date.now().toString(), ["Hello BUIDLERS1"]));
baru.addBlock(new block(Date.now().toString(), ["Hello BUIDLERS2"]));
baru.addBlock(new block(Date.now().toString(), ["Hello BUIDLERS3"]));
// baru.Chain[1].data = [1];

console.log(baru);

// difficuly = 4;
// "0000gaghshghashhahs