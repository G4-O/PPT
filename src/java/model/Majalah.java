package model;

public class Majalah extends ItemPerpustakaan {
    private int edisi;
    private String gambarUrl;

    public Majalah(String judul, String idItem, int edisi, String gambarUrl, int stok) {
        super(judul, idItem, stok);
        this.edisi = edisi;
        this.gambarUrl = gambarUrl;
    }

    public int getEdisi() {
        return edisi;
    }

    public void setEdisi(int edisi) {
        this.edisi = edisi;
    }

    @Override
    public void tampilkanInfo() {
        System.out.println("Majalah: " + judul + " | Edisi: " + edisi);
    }

    @Override
    public String getGambarUrl() {
        return gambarUrl;
    }
    
    @Override
    public String getItemType() {
        return "majalah";
    }
}
