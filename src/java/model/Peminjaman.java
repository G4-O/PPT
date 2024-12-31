package model;

import java.time.LocalDate;
import java.time.ZoneId;

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

    // Method untuk menghitung status peminjaman
    public String getStatusPeminjaman() {
        LocalDate currentDate = LocalDate.now();
        LocalDate dueDate = LocalDate.ofEpochDay(tanggalKembali / (24 * 3600));

        if (currentDate.isAfter(dueDate)) {
            long overdueDays = currentDate.toEpochDay() - dueDate.toEpochDay();
            return "Overdue by " + overdueDays + " days";
        } else if (currentDate.isEqual(dueDate)) {
            return "Due today, please return!";
        } else {
            long daysRemaining = dueDate.toEpochDay() - currentDate.toEpochDay();
            return daysRemaining + " days remaining";
        }
    }
}
