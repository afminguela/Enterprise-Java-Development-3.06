package com.taskjava.task.models;
public enum TaskPriority {
    LOW("Low Priority"),
    MEDIUM("Medium Priority"),
    HIGH("High Priority"),
    URGENT("Urgent Priority");

    private final String displayName;

    TaskPriority(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}