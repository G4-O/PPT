/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.List;

/**
 *
 * @author Belacks
 */
public class CD extends ItemPerpustakaan {
    private String artis;
    private int durasi;

    public CD(String judul, String idItem, String artis, int durasi) {
        super(judul, idItem);
        this.artis = artis;
        this.durasi = durasi;
    }

    /*@Override
    public void tampilkanInfo(List<Peminjaman> lp) {
        System.out.println("CD: " + judul + " | Artis: " + artis + " | Durasi: " + durasi + " menit");
        System.out.println("Status: " + (statusDipinjam(lp) ? "Dipinjam" : "Tersedia"));
    }*/

    @Override
    public void tampilkanInfo() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}

