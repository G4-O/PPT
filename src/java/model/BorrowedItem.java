package model;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class BorrowedItem {
    private String idItem;
    private String title;
    private String type;
    private String authorOrDirector;
    private String imageUrl;
    private LocalDate borrowDate;
    private LocalDate returnDate;
    private long daysRemaining;
    private boolean isOverdue;
    private long overdueDays;

    public BorrowedItem(String idItem, String title, String type, String authorOrDirector, 
                       String imageUrl, LocalDate borrowDate, LocalDate returnDate) {
        this.idItem = idItem;
        this.title = title;
        this.type = type;
        this.authorOrDirector = authorOrDirector;
        this.imageUrl = imageUrl;
        this.borrowDate = borrowDate;
        this.returnDate = returnDate;
        
        LocalDate today = LocalDate.now();
        if (today.isBefore(returnDate)) {
            this.daysRemaining = ChronoUnit.DAYS.between(today, returnDate);
            this.isOverdue = false;
            this.overdueDays = 0;
        } else {
            this.daysRemaining = 0;
            this.isOverdue = true;
            this.overdueDays = ChronoUnit.DAYS.between(returnDate, today);
        }
    }

    // Getters and setters
    public String getIdItem() {
        return idItem;
    }

    public void setIdItem(String idItem) {
        this.idItem = idItem;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getAuthorOrDirector() {
        return authorOrDirector;
    }

    public void setAuthorOrDirector(String authorOrDirector) {
        this.authorOrDirector = authorOrDirector;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public LocalDate getBorrowDate() {
        return borrowDate;
    }

    public void setBorrowDate(LocalDate borrowDate) {
        this.borrowDate = borrowDate;
        updateDaysCalculation();
    }

    public LocalDate getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(LocalDate returnDate) {
        this.returnDate = returnDate;
        updateDaysCalculation();
    }

    public long getDaysRemaining() {
        return daysRemaining;
    }

    public boolean isOverdue() {
        return isOverdue;
    }

    public long getOverdueDays() {
        return overdueDays;
    }

    // Helper method to update days calculation when dates change
    private void updateDaysCalculation() {
        LocalDate today = LocalDate.now();
        if (today.isBefore(returnDate)) {
            this.daysRemaining = ChronoUnit.DAYS.between(today, returnDate);
            this.isOverdue = false;
            this.overdueDays = 0;
        } else {
            this.daysRemaining = 0;
            this.isOverdue = true;
            this.overdueDays = ChronoUnit.DAYS.between(returnDate, today);
        }
    }

    // Optional: Override toString() for debugging
    @Override
    public String toString() {
        return "BorrowedItem{" +
                "idItem='" + idItem + '\'' +
                ", title='" + title + '\'' +
                ", type='" + type + '\'' +
                ", authorOrDirector='" + authorOrDirector + '\'' +
                ", imageUrl='" + imageUrl + '\'' +
                ", borrowDate=" + borrowDate +
                ", returnDate=" + returnDate +
                ", daysRemaining=" + daysRemaining +
                ", isOverdue=" + isOverdue +
                ", overdueDays=" + overdueDays +
                '}';
    }
}