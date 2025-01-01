package model;

public class TrendingItem extends ItemPerpustakaan {
    private int jumlahPeminjaman;
    private String gambarUrl;
    private String itemType;
    private String detail;
    
    public TrendingItem(String judul, String idItem, int stok, int jumlahPeminjaman, String gambarUrl, String detail, String itemType) {
        super(judul, idItem, stok);
        this.jumlahPeminjaman = jumlahPeminjaman;
        this.gambarUrl = gambarUrl;
        this.detail = detail;
        this.itemType = itemType;
    }
    
    @Override
    public void tampilkanInfo() {
        System.out.println("Judul: " + judul);
        System.out.println("ID: " + idItem);
        System.out.println("Stok: " + stok);
        System.out.println("Detail: " + detail);
        System.out.println("Tipe Item: " + itemType);
        System.out.println("Jumlah Peminjaman: " + jumlahPeminjaman);
    }
    
    @Override
    public String getGambarUrl() {
        return this.gambarUrl;
    }
    
    @Override
    public String getItemType() {
        return this.itemType;
    }
    
    public int getJumlahPeminjaman() {
        return jumlahPeminjaman;
    }
    
    public String getDetail() {
        return detail;
    }
}