package com.taskjava.task.models;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Column;

import java.time.LocalDate;

@Entity
@DiscriminatorValue("INTERNAL")
public class InternalTask extends Task {


    @Column(name = "department")
    private String department;

    @Enumerated(EnumType.STRING)
    @Column(name = "priority")
    private TaskPriority priority = TaskPriority.MEDIUM;

    // Constructors
    protected InternalTask() {
        super();
    }

    public InternalTask(String title, LocalDate dueDate) {
        super(title, dueDate);
    }

    public InternalTask(String title, LocalDate dueDate, String department, TaskPriority priority) {
        super(title, dueDate);
        this.department = department;
        this.priority = priority;
    }

    // Getters and Setters
    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }

    public TaskPriority getPriority() { return priority; }
    public void setPriority(TaskPriority priority) { this.priority = priority; }
}