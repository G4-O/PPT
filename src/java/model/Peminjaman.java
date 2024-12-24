package model;

public class Peminjaman extends Transaksi {
    private long tanggalKembali;

    public Peminjaman(String idTransaksi, ItemPerpustakaan item, User user, long tanggalTransaksi, long tanggalKembali) {
        super(idTransaksi, item, user, tanggalTransaksi);
        this.tanggalKembali = tanggalKembali;
    }

    @Override
    public void detailTransaksi() {
        System.out.println("Peminjaman ID: " + idTransaksi);
        System.out.println("Item: " + item.judul);
        System.out.println("Anggota: " + user.getNama());
        System.out.println("Tanggal Peminjaman: " + tanggalTransaksi);
        System.out.println("Tanggal Kembali: " + tanggalKembali);
    }

    public long getTanggalKembali() {
        return tanggalKembali;
    }

    public ItemPerpustakaan getItem() {
        return item;
    }
}
