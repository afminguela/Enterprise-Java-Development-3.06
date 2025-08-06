package com.taskjava.task.models;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;
import org.antlr.v4.runtime.misc.NotNull;
import org.springframework.data.relational.core.mapping.Column;

import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@DiscriminatorValue("BILLABLE")
public class BillableTask extends Task {

    @NotNull(message = "Hourly rate cannot be null")

    @Column(name = "hourly_rate", precision = 10, scale = 2, nullable = false)
    private BigDecimal hourlyRate;


    @Column(name = "hours_worked", columnDefinition = "INTEGER DEFAULT 0")
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
