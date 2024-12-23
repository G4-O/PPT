package model;

public class DVD extends ItemPerpustakaan {
    private String sutradara;
    private int durasi;
    private String gambarUrl;

    public DVD(String judul, String idItem, String sutradara, int durasi, String gambarUrl) {
        super(judul, idItem);
        this.sutradara = sutradara;
        this.durasi = durasi;
        this.gambarUrl = gambarUrl;
    }

    @Override
    public void tampilkanInfo() {
        System.out.println("DVD: " + judul + " | Sutradara: " + sutradara + " | Durasi: " + durasi + " menit");
    }

    @Override
    public String getGambarUrl() {
        return gambarUrl;
    }
    
    @Override
    public String getItemType() {
        return "dvd";
    }
}
