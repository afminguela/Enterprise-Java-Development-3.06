package com.taskjava.task.models;
import javax.persistence.*;
import javax.validation.constraints.*;

import jakarta.persistence.*;
import org.antlr.v4.runtime.misc.NotNull;
import org.springframework.data.annotation.Id;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.time.LocalDate;


// Base Task Entity (Abstract class using Table Per Class inheritance)
@Entity
@Table(name = "tasks")

public abstract class Task {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;


    @Column(nullable = false, length = 255)
    private String title;

    @Column(name = "due_date")
    private LocalDate dueDate;

    @NotNull
    @Column(nullable = false, columnDefinition = "BOOLEAN DEFAULT FALSE")
    private Boolean status = false; // false = incomplete, true = complete

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDate createdAt;

    @Column(name = "updated_at")
    private LocalDate updatedAt;

    // Constructors
    protected Task() {
        this.createdAt = LocalDate.now();
        this.updatedAt = LocalDate.now();
    }

    public Task(String title, LocalDate dueDate) {
        this();
        this.title = title;
        this.dueDate = dueDate;
        this.status = false;
    }

    // JPA Lifecycle methods
    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = LocalDate.now();
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public LocalDate getDueDate() { return dueDate; }
    public void setDueDate(LocalDate dueDate) { this.dueDate = dueDate; }

    public Boolean getStatus() { return status; }
    public void setStatus(Boolean status) { this.status = status; }

    public LocalDate getCreatedAt() { return createdAt; }
    public LocalDate getUpdatedAt() { return updatedAt; }

    // Business methods
    public boolean isCompleted() { return Boolean.TRUE.equals(status); }
    public boolean isOverdue() {
        return dueDate != null && LocalDate.now().isAfter(dueDate) && !isCompleted();
    }
    public void markCompleted() { this.status = true; }
    public void markIncomplete() { this.status = false; }

    @Override
    public String toString() {
        return String.format("%s{id=%d, title='%s', dueDate=%s, status=%s}",
                getClass().getSimpleName(), id, title, dueDate, status);
    }
}

