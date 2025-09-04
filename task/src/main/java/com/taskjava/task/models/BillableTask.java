package com.taskjava.task.models;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;
import jakarta.persistence.Column;

import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@DiscriminatorValue("BILLABLE")
public class BillableTask extends Task {

    @Column(name = "hourly_rate", nullable = false)
    private BigDecimal hourlyRate;

    @Column(name = "hours_worked")
    private Integer hoursWorked = 0;

    // Constructors
    protected BillableTask() {
        super();
    }

    public BillableTask(String title, LocalDate dueDate, BigDecimal hourlyRate) {
        super(title, dueDate);
        this.hourlyRate = hourlyRate;
    }

    // Getters and Setters
    public BigDecimal getHourlyRate() { return hourlyRate; }
    public void setHourlyRate(BigDecimal hourlyRate) { this.hourlyRate = hourlyRate; }

    public Integer getHoursWorked() { return hoursWorked; }
    public void setHoursWorked(Integer hoursWorked) { this.hoursWorked = hoursWorked; }

    // Business methods
    public BigDecimal calculateTotalCost() {
        if (hourlyRate == null || hoursWorked == null) {
            return BigDecimal.ZERO;
        }
        return hourlyRate.multiply(BigDecimal.valueOf(hoursWorked));
    }

    public BigDecimal getEstimatedCost(int estimatedHours) {
        return hourlyRate != null ?
                hourlyRate.multiply(BigDecimal.valueOf(estimatedHours)) :
                BigDecimal.ZERO;
    }
}
