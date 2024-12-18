/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package model;

import java.util.List;

/**
 *
 * @author Belacks
 */
public interface ManajemenPeminjaman {
    void pinjamItem(ItemPerpustakaan item, long durasiPinjam, List<Peminjaman> l);
    void kembalikanItem(ItemPerpustakaan item, List<Peminjaman> l);
}
