/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.mycompany.tubes;

/**
 *
 * @author Belacks
 */
public interface ManajemenPeminjaman {
    void pinjamItem(ItemPerpustakaan item, String tanggalPinjam);
    void kembalikanItem(ItemPerpustakaan item, String tanggalKembali);
}
