/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Belacks
 */
public abstract class ItemPerpustakaan {
    protected String judul;
    protected String idItem;
    protected boolean statusDipinjam = false;
    protected boolean isReserved = false; // Penanda apakah item sedang direservasi

    public ItemPerpustakaan(String judul, String idItem) {
        this.judul = judul;
        this.idItem = idItem;
    }
    public ItemPerpustakaan(String judul, String idItem, boolean statusDipinjam) {
        this.judul = judul;
        this.idItem = idItem;
        this.statusDipinjam = statusDipinjam;
    }

    // Metode untuk melakukan reservasi
    public void reservasiItem() {
        if (!statusDipinjam && !isReserved) {
            isReserved = true;
            System.out.println(judul + " telah berhasil direservasi.");
        } else {
            System.out.println("Item ini tidak dapat direservasi saat ini.");
        }
    }

    // Membatalkan reservasi
    public void batalkanReservasi() {
        if (isReserved) {
            isReserved = false;
            System.out.println(judul + " reservasi telah dibatalkan.");
        }
    }
    
    public boolean isAvailable(){
        return !this.isReserved&&!this.statusDipinjam;
    }
    
    public abstract void tampilkanInfo();

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

    public boolean isStatusDipinjam() {
        return statusDipinjam;
    }

    public void setStatusDipinjam(boolean statusDipinjam) {
        this.statusDipinjam = statusDipinjam;
    }

    public boolean isIsReserved() {
        return isReserved;
    }

    public void setIsReserved(boolean isReserved) {
        this.isReserved = isReserved;
    }
    
    
}
