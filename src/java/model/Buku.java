package model;

public class Buku extends ItemPerpustakaan {
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    
    private String penulis;
    private int tahunTerbit;
    private String gambarUrl; // URL gambar

    public Buku(String judul, String idItem, String penulis, int tahunTerbit, String gambarUrl, int stok) {
        super(judul, idItem, stok);
        this.penulis = penulis;
        this.tahunTerbit = tahunTerbit;
        this.gambarUrl = gambarUrl;
    }

    public int getTahunTerbit() {
        return tahunTerbit;
    }

    public String getPenulis() {
        return penulis;
    }

    
    @Override
    public String getGambarUrl() {
        return gambarUrl;
    }

    @Override
    public void tampilkanInfo() {
        System.out.println("Buku: " + judul + " | Penulis: " + penulis + " | Tahun: " + tahunTerbit);
    }
    
    @Override
    public String getItemType() {
        return "buku";
    }
}
