package model;

public class DVD extends ItemPerpustakaan {
    private String sutradara;
    private int durasi;
    private String gambarUrl;

    public DVD(String judul, String idItem, String sutradara, int durasi, String gambarUrl, int stok) {
        super(judul, idItem, stok);
        this.sutradara = sutradara;
        this.durasi = durasi;
        this.gambarUrl = gambarUrl;
    }

    public String getSutradara() {
        return sutradara;
    }

    public void setSutradara(String sutradara) {
        this.sutradara = sutradara;
    }

    public int getDurasi() {
        return durasi;
    }

    public void setDurasi(int durasi) {
        this.durasi = durasi;
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
