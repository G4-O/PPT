/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.tubes;
import java.util.ArrayList;

/**
 *
 * @author Belacks
 */
public class Catalogue {
    private ArrayList<ItemPerpustakaan> daftarItem = new ArrayList<>();

    public void tambahItem(ItemPerpustakaan item) {
        daftarItem.add(item);
    }

    public void cariItemBerdasarkanJudul(String judul) {
        System.out.println("Hasil pencarian untuk judul: " + judul);
        for (ItemPerpustakaan item : daftarItem) {
            if (item.judul.equalsIgnoreCase(judul)) {
                item.tampilkanInfo();
            }
        }
    }

    public void cariItemBerdasarkanTahun(int tahunTerbit) {
        System.out.println("Hasil pencarian untuk tahun: " + tahunTerbit);
        for (ItemPerpustakaan item : daftarItem) {
            if (item instanceof Buku && ((Buku) item).getTahunTerbit() == tahunTerbit) {
                item.tampilkanInfo();
            }
        }
    }

    public void cariItemBerdasarkanPenulis(String penulis) {
        System.out.println("Hasil pencarian untuk penulis: " + penulis);
        for (ItemPerpustakaan item : daftarItem) {
            if (item instanceof Buku && ((Buku) item).getPenulis().equalsIgnoreCase(penulis)) {
                item.tampilkanInfo();
            }
        }
    }

    public void tampilkanKatalog() {
        for (ItemPerpustakaan item : daftarItem) {
            item.tampilkanInfo();
        }
    }
}
