// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract perpusrkaan{
    address public admin;

// mendefinisikan variabel identitas buku

    struct identitas_buku{
        uint256 isbn;
        string Judul;
        string penulis;
        uint16 tahun_terbit;
        bool benar;
    }

    mapping (uint256 => identitas_buku) public  buku;

    // membuat event untuk melakukan perubahan buku, penambahan buku serta penghapusan buku

    event addBuku(uint256 indexed isbn, string _Judul, string Nama_penulis, uint16 tahun_terbit);
    event updateBuku(uint256 indexed isbn, string Judul_baru, string Nama_penulis_baru, uint16 tahun_terbit_baru);
    event deleteBuku(uint256 indexed isbn);
    event addadmin(address indexed id, string name);

     modifier hanyaAdmin() {
        require(msg.sender == admin, "Hanya admin yang dapat mengedit");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    function addbuku(uint256 _isbn, string memory _judul, string memory Nama_penulis, uint16  tahun_terbit ) public hanyaAdmin{
    require(!buku[_isbn].benar, "Maaf Buku dengan ISDN ini telah terdaftar");
        buku[_isbn] = identitas_buku(_isbn, _judul, Nama_penulis, tahun_terbit, true );
        emit addBuku(_isbn, _judul, Nama_penulis, tahun_terbit);
}

    function updatebuku(uint256 _isbn, string memory Judul_baru, string memory Nama_penulis_baru, uint16  tahun_terbit_baru ) public hanyaAdmin{
        require(buku[_isbn].benar, "Maaf Buku dengan ISDN ini sudah diupdate");
        buku[_isbn].Judul = Judul_baru;
        buku[_isbn].penulis = Nama_penulis_baru;
        buku [_isbn].tahun_terbit= tahun_terbit_baru;
        emit updateBuku(_isbn, Nama_penulis_baru, Nama_penulis_baru, tahun_terbit_baru);
}

    function delatebuku(uint256 _isbn) public hanyaAdmin{
        require(buku[_isbn].benar, "Maaf Buku dengan ISDN ini telah dihapus");
        delete buku[_isbn];
        emit deleteBuku(_isbn); 
}

    function getbuku(uint256 _isbn) public view returns(string memory Judul, string memory penulis, uint16  tahun_terbit ){
       require(buku[_isbn].benar, "Maaf Buku dengan ISDN ini telah terdaftar");
       return (buku[_isbn].Judul, buku[_isbn].penulis, buku[_isbn].tahun_terbit);
}



}