package model;

public class Jurnal extends ItemPerpustakaan {
    private String penulis;
    private String bidang;
    private String gambarUrl;

    public Jurnal(String judul, String idItem, String penulis, String bidang, String gambarUrl) {
        super(judul, idItem);
        this.penulis = penulis;
        this.bidang = bidang;
        this.gambarUrl = gambarUrl;
    }

    @Override
    public void tampilkanInfo() {
        System.out.println("Jurnal: " + judul + " | Penulis: " + penulis + " | Bidang: " + bidang);
    }

    @Override
    public String getGambarUrl() {
        return gambarUrl;
    }
    
    @Override
    public String getItemType() {
        return "jurnal";
    }
}
