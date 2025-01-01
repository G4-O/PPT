package model;

public class Jurnal extends ItemPerpustakaan {
    private String penulis;
    private String bidang;
    private String gambarUrl;

    public Jurnal(String judul, String idItem, String penulis, String bidang, String gambarUrl, int stok) {
        super(judul, idItem, stok);
        this.penulis = penulis;
        this.bidang = bidang;
        this.gambarUrl = gambarUrl;
    }

    public String getPenulis() {
        return penulis;
    }

    public void setPenulis(String penulis) {
        this.penulis = penulis;
    }

    public String getBidang() {
        return bidang;
    }

    public void setBidang(String bidang) {
        this.bidang = bidang;
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
