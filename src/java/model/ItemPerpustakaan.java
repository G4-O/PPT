/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Iterator;
import java.util.List;
import java.util.UUID;

/**
 *
 * @author Belacks
 */
public abstract class ItemPerpustakaan {
    protected String judul;
    protected String idItem;
    protected int stok;
    
    public ItemPerpustakaan(String judul, String idItem, int stok) {
        this.judul = judul;
        this.idItem = idItem;
        this.stok = stok;
    }

    public int getStok() {
        return stok;
    }

    public void setStok(int stok) {
        this.stok = stok;
    }
   
    
    public boolean statusDipinjam(List<Peminjaman> l) {
        long unixTime = System.currentTimeMillis() / 1000L;
        int dipinjam = 0;

        for (Peminjaman r : l) {
            if (r.item.idItem.equals(this.idItem) && r.getTanggalKembali() > unixTime) {
                dipinjam++;
            }
        }

        return dipinjam >= this.stok;
    }
    
    
    // Metode untuk melakukan reservasi
    public void pinjamItem(List<Peminjaman> lp, User user, long deadline) {
        long unixTime = System.currentTimeMillis() / 1000L;
        if (!statusDipinjam(lp)) {
            UUID uuid = UUID.randomUUID();
            String uuidAsString = uuid.toString();

            lp.add(new Peminjaman(uuidAsString, this, user, unixTime, deadline));
            System.out.println(judul + " telah berhasil direservasi.");
        } else {
            System.out.println("Item ini tidak dapat direservasi saat ini.");
        }
    }

    // Membatalkan reservasi
    public void batalkanPeminjaman(String id, List<Peminjaman> lr) {
        Iterator<Peminjaman> iterator= lr.iterator();
        while (iterator.hasNext()){
            var entry = iterator.next();
            if (entry.item.idItem.equals(id)){iterator.remove();}
        }
    }
    
    public boolean isAvailable(List<Peminjaman> lp) {
        return !this.statusDipinjam(lp) && this.stok > 0;
    }
    
    public abstract void tampilkanInfo();
    
    public abstract String getGambarUrl(); // Add this abstract method

    public String getJudul() {
        return judul;
    }

    public void setJudul(String judul) {
        this.judul = judul;
    }

    public String getIdItem() {
        return idItem;
    }

    public void setIdItem(String idItem) {
        this.idItem = idItem;
    }
    
    public abstract String getItemType();
}
