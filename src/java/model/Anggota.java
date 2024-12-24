package model;

import java.util.List;


// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED
// DEPRECATED

public class Anggota implements ManajemenPeminjaman {
    protected String nama;
    protected String idAnggota;

    public Anggota(String nama, String idAnggota) {
        this.nama = nama;
        this.idAnggota = idAnggota;
    }

    @Override
    public void pinjamItem(ItemPerpustakaan item, long durasiPinjam, List<Peminjaman> peminjamanList) {
        long unixTime = System.currentTimeMillis() / 1000L;
        if (item.isAvailable(peminjamanList)) {
            //item.pinjamItem(peminjamanList, this, unixTime + durasiPinjam);
            System.out.println(nama + " meminjam " + item.judul + " selama " + (durasiPinjam / (3600 * 24)) + " hari");
        } else {
            System.out.println("Item tidak tersedia.");
        }
    }

    @Override
    public void kembalikanItem(ItemPerpustakaan item, List<Peminjaman> peminjamanList) {
        item.batalkanPeminjaman(item.idItem, peminjamanList);
        System.out.println(nama + " mengembalikan " + item.judul);
    }

    public void tampilkanInfo() {
        System.out.println("ID: " + idAnggota);
        System.out.println("Nama: " + nama);
    }
}
