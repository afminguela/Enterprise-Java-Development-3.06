# Project Issues Tracking

This document contains all the issues identified from the project plan outlined in the README.md. Each issue is structured with clear requirements, acceptance criteria, and implementation details.

## Phase 1: Fix Current Implementation (Critical Priority)

### Issue #1: Fix Jakarta/Javax Import Conflicts
**Priority:** P0 - Critical  
**Type:** Bug  
**Labels:** compilation-error, dependencies

**Description:**
The project currently has compilation errors due to mixed javax and jakarta imports. All imports should use jakarta.persistence.* consistently for Spring Boot 3.x compatibility.

**Current Errors:**
- `package javax.persistence does not exist`
- `package javax.validation.constraints does not exist`

**Acceptance Criteria:**
- [ ] Replace all `javax.persistence.*` imports with `jakarta.persistence.*`
- [ ] Replace all `javax.validation.*` imports with `jakarta.validation.*`
- [ ] Project compiles without import-related errors
- [ ] All entity annotations work correctly

**Files to Update:**
- `src/main/java/com/taskjava/task/models/Task.java`
- `src/main/java/com/taskjava/task/models/BillableTask.java`
- `src/main/java/com/taskjava/task/models/InternalTask.java`

---

### Issue #2: Fix @Column Annotation Usage
**Priority:** P0 - Critical  
**Type:** Bug  
**Labels:** compilation-error, jpa-annotations

**Description:**
The project is incorrectly using Spring Data `@Column` annotations instead of JPA `@Column` annotations, causing compilation errors.

**Current Errors:**
- `cannot find symbol: method name() location: @interface org.springframework.data.relational.core.mapping.Column`
- `cannot find symbol: method precision() location: @interface org.springframework.data.relational.core.mapping.Column`

**Acceptance Criteria:**
- [ ] Replace all Spring Data `@Column` imports with JPA `@Column` imports
- [ ] Ensure all `@Column` annotation attributes are valid JPA attributes
- [ ] Project compiles without @Column-related errors
- [ ] Database column mappings work correctly

**Technical Details:**
- Use `jakarta.persistence.Column` instead of `org.springframework.data.relational.core.mapping.Column`
- Ensure attributes like `name`, `precision`, `scale`, `nullable`, `length`, `columnDefinition` are used correctly

---

### Issue #3: Add Missing @Inheritance Strategy to Task Entity
**Priority:** P0 - Critical  
**Type:** Enhancement  
**Labels:** jpa-inheritance, entity-design

**Description:**
The base Task entity is missing the @Inheritance annotation, which is required for JPA entity inheritance to work properly.

**Acceptance Criteria:**
- [ ] Add `@Inheritance` annotation to Task entity
- [ ] Choose appropriate inheritance strategy (TABLE_PER_CLASS, SINGLE_TABLE, or JOINED)
- [ ] Add `@DiscriminatorColumn` if using SINGLE_TABLE strategy
- [ ] Add `@DiscriminatorValue` to BillableTask and InternalTask
- [ ] Document the chosen inheritance strategy and reasoning

**Technical Details:**
- Recommended strategy: `@Inheritance(strategy = InheritanceType.SINGLE_TABLE)` for simplicity
- Use `@DiscriminatorColumn(name = "task_type")` if using SINGLE_TABLE

---

### Issue #4: Add Missing Validation Annotations
**Priority:** P1 - High  
**Type:** Enhancement  
**Labels:** validation, data-integrity

**Description:**
Add proper validation annotations to ensure data integrity and provide meaningful error messages.

**Acceptance Criteria:**
- [ ] Add `@NotNull` validation to required fields (title, dueDate, status)
- [ ] Add `@NotBlank` to string fields that shouldn't be empty
- [ ] Add `@DecimalMin` and `@DecimalMax` to hourlyRate in BillableTask
- [ ] Add `@Size` constraints to string fields with length limits
- [ ] Add `@PastOrPresent` or `@Future` to dueDate as appropriate

**Fields to Validate:**
- Task: title (NotBlank), dueDate (NotNull), status (NotNull)
- BillableTask: hourlyRate (NotNull, DecimalMin)
- InternalTask: department (NotBlank), priority (NotNull)

---

### Issue #5: Ensure Project Builds Successfully
**Priority:** P0 - Critical  
**Type:** Task  
**Labels:** build, integration

**Description:**
After fixing all compilation errors, ensure the project builds successfully and all tests pass.

**Acceptance Criteria:**
- [ ] `./mvnw clean compile` completes without errors
- [ ] `./mvnw test` passes all existing tests
- [ ] `./mvnw spring-boot:run` starts the application successfully
- [ ] No compilation warnings related to the fixes

## Phase 2: Complete Task Management System

### Issue #6: Create TaskRepository Interface
**Priority:** P1 - High  
**Type:** Feature  
**Labels:** repository, data-access

**Description:**
Create Spring Data JPA repository interface for Task entities to enable database operations.

**Acceptance Criteria:**
- [ ] Create `TaskRepository` interface extending `JpaRepository<Task, Long>`
- [ ] Add custom query methods for common operations:
  - `findByStatus(Boolean status)`
  - `findByDueDateBefore(LocalDate date)`
  - `findByDueDateAfter(LocalDate date)`
- [ ] Add repository for BillableTask with hourly rate queries
- [ ] Add repository for InternalTask with department and priority queries

**Files to Create:**
- `src/main/java/com/taskjava/task/repositories/TaskRepository.java`
- `src/main/java/com/taskjava/task/repositories/BillableTaskRepository.java`
- `src/main/java/com/taskjava/task/repositories/InternalTaskRepository.java`

---

### Issue #7: Add Service Layer for Business Logic
**Priority:** P1 - High  
**Type:** Feature  
**Labels:** service-layer, business-logic

**Description:**
Implement service layer to handle business logic and provide a clean API for controllers.

**Acceptance Criteria:**
- [ ] Create `TaskService` interface with CRUD operations
- [ ] Implement `TaskServiceImpl` with business logic
- [ ] Add methods for task status management
- [ ] Add methods for overdue task detection
- [ ] Add methods for calculating billable hours/costs
- [ ] Include proper exception handling

**Business Methods to Include:**
- `createTask(TaskDto taskDto)`
- `updateTaskStatus(Long id, Boolean status)`
- `getOverdueTasks()`
- `calculateTotalBillableAmount(LocalDate startDate, LocalDate endDate)`

---

### Issue #8: Create Unit Tests for All Entities
**Priority:** P1 - High  
**Type:** Testing  
**Labels:** unit-tests, entities

**Description:**
Create comprehensive unit tests for all entity classes to ensure proper functionality.

**Acceptance Criteria:**
- [ ] Test Task entity creation and validation
- [ ] Test BillableTask hourly rate calculations
- [ ] Test InternalTask priority and department handling
- [ ] Test entity inheritance behavior
- [ ] Test validation annotations work correctly
- [ ] Achieve minimum 80% code coverage for entities

**Test Files to Create:**
- `src/test/java/com/taskjava/task/models/TaskTest.java`
- `src/test/java/com/taskjava/task/models/BillableTaskTest.java`
- `src/test/java/com/taskjava/task/models/InternalTaskTest.java`

---

### Issue #9: Add Integration Tests
**Priority:** P2 - Medium  
**Type:** Testing  
**Labels:** integration-tests, database

**Description:**
Create integration tests to verify database operations and repository functionality.

**Acceptance Criteria:**
- [ ] Test repository CRUD operations
- [ ] Test custom query methods
- [ ] Test entity inheritance at database level
- [ ] Test transaction handling
- [ ] Use `@DataJpaTest` for repository testing
- [ ] Use `@SpringBootTest` for full integration testing

---

### Issue #10: Document Inheritance Strategy
**Priority:** P2 - Medium  
**Type:** Documentation  
**Labels:** documentation, jpa-inheritance

**Description:**
Document the chosen JPA inheritance strategy and explain the reasoning behind the choice.

**Acceptance Criteria:**
- [ ] Create documentation explaining the inheritance strategy used
- [ ] Compare different inheritance strategies (SINGLE_TABLE, JOINED, TABLE_PER_CLASS)
- [ ] Explain pros and cons of the chosen strategy
- [ ] Include database schema examples
- [ ] Add performance considerations

## Phase 3: Implement PR Company System

### Issue #11: Create Name Embeddable Entity
**Priority:** P2 - Medium  
**Type:** Feature  
**Labels:** embedded-entity, jpa

**Description:**
Create an embeddable Name entity with firstName, lastName, middleName, and salutation fields.

**Acceptance Criteria:**
- [ ] Create `Name` class with `@Embeddable` annotation
- [ ] Add fields: firstName, lastName, middleName, salutation
- [ ] Add appropriate validation annotations
- [ ] Implement equals, hashCode, and toString methods
- [ ] Add constructor overloads for convenience

**File to Create:**
- `src/main/java/com/taskjava/task/models/Name.java`

---

### Issue #12: Create Contact Entity with Embedded Name
**Priority:** P2 - Medium  
**Type:** Feature  
**Labels:** entity, embedded

**Description:**
Create Contact entity that embeds the Name entity and includes title and company fields.

**Acceptance Criteria:**
- [ ] Create `Contact` entity with JPA annotations
- [ ] Embed `Name` using `@Embedded` annotation
- [ ] Add title and company fields
- [ ] Add proper validation annotations
- [ ] Ensure embedded Name is not stored in separate table
- [ ] Test the embedded relationship

**File to Create:**
- `src/main/java/com/taskjava/task/models/Contact.java`

---

### Issue #13: Create ContactRepository Interface
**Priority:** P2 - Medium  
**Type:** Feature  
**Labels:** repository, embedded-queries

**Description:**
Create repository interface for Contact entities with queries that work with embedded Name fields.

**Acceptance Criteria:**
- [ ] Create `ContactRepository` extending `JpaRepository<Contact, Long>`
- [ ] Add queries for embedded name fields:
  - `findByName_FirstNameContaining(String firstName)`
  - `findByName_LastNameContaining(String lastName)`
- [ ] Add queries for company and title
- [ ] Test embedded field queries work correctly

---

### Issue #14: Add Contact Service Layer
**Priority:** P2 - Medium  
**Type:** Feature  
**Labels:** service-layer, contact-management

**Description:**
Implement service layer for Contact management with business logic.

**Acceptance Criteria:**
- [ ] Create `ContactService` interface
- [ ] Implement `ContactServiceImpl`
- [ ] Add methods for contact search by name components
- [ ] Add methods for company-based grouping
- [ ] Include proper validation and exception handling

---

### Issue #15: Create Tests for Embedded Entities
**Priority:** P2 - Medium  
**Type:** Testing  
**Labels:** testing, embedded-entities

**Description:**
Create comprehensive tests for embedded entity functionality.

**Acceptance Criteria:**
- [ ] Test Name embeddable creation and validation
- [ ] Test Contact entity with embedded Name
- [ ] Test repository queries with embedded fields
- [ ] Test that embedded fields are not stored in separate tables
- [ ] Verify database schema is correct

## Phase 4: Documentation and Analysis

### Issue #16: Document Native SQL vs JPQL Tasks
**Priority:** P2 - Medium  
**Type:** Documentation  
**Labels:** documentation, sql, jpql

**Description:**
Research and document 3 specific tasks that require native SQL over JPQL, with detailed explanations.

**Acceptance Criteria:**
- [ ] Identify 3 concrete examples where native SQL is necessary
- [ ] Provide code examples for each case
- [ ] Explain technical limitations of JPQL for each case
- [ ] Include performance considerations
- [ ] Add database-specific examples (MySQL, PostgreSQL)

**Suggested Examples:**
1. Complex database-specific functions and procedures
2. Dynamic table/column names
3. Database-specific optimization hints

---

### Issue #17: Create Code Examples for SQL vs JPQL
**Priority:** P3 - Low  
**Type:** Documentation  
**Labels:** examples, sql-comparison

**Description:**
Create practical code examples demonstrating the differences between native SQL and JPQL.

**Acceptance Criteria:**
- [ ] Create working examples in the repository
- [ ] Show equivalent JPQL where possible
- [ ] Demonstrate cases where JPQL cannot be used
- [ ] Include performance benchmarks if applicable
- [ ] Add comments explaining the differences

---

### Issue #18: Update README with Implementation Details
**Priority:** P3 - Low  
**Type:** Documentation  
**Labels:** readme, documentation

**Description:**
Update the README.md with final implementation details and current project status.

**Acceptance Criteria:**
- [ ] Update completed features checklist
- [ ] Add implementation notes for inheritance strategy
- [ ] Document the embedded entity approach
- [ ] Add setup and running instructions
- [ ] Include troubleshooting section

## Phase 5: Final Polish

### Issue #19: Add Comprehensive JavaDoc Comments
**Priority:** P3 - Low  
**Type:** Documentation  
**Labels:** javadoc, code-documentation

**Description:**
Add detailed JavaDoc comments to all classes, methods, and important fields.

**Acceptance Criteria:**
- [ ] Add class-level JavaDoc for all entities
- [ ] Document all public methods with parameters and return values
- [ ] Add field documentation for complex business logic
- [ ] Include usage examples in JavaDoc
- [ ] Generate JavaDoc HTML and verify completeness

---

### Issue #20: Create Database Initialization Scripts
**Priority:** P3 - Low  
**Type:** Infrastructure  
**Labels:** database, initialization

**Description:**
Create SQL scripts to initialize the database with schema and sample data.

**Acceptance Criteria:**
- [ ] Create schema.sql with table definitions
- [ ] Create data.sql with sample data
- [ ] Ensure scripts work with different databases (MySQL, H2)
- [ ] Add scripts to resources directory
- [ ] Test initialization on clean database

---

### Issue #21: Add Example Data and Use Cases
**Priority:** P3 - Low  
**Type:** Documentation  
**Labels:** examples, use-cases

**Description:**
Create comprehensive examples showing how to use the system with realistic data.

**Acceptance Criteria:**
- [ ] Create realistic sample tasks (billable and internal)
- [ ] Add sample contacts with proper name structure
- [ ] Create example scenarios for common operations
- [ ] Add API usage examples
- [ ] Include business workflow examples

---

### Issue #22: Performance Optimization Notes
**Priority:** P3 - Low  
**Type:** Documentation  
**Labels:** performance, optimization

**Description:**
Document performance considerations and optimization strategies for the implemented system.

**Acceptance Criteria:**
- [ ] Analyze and document query performance
- [ ] Provide indexing recommendations
- [ ] Document caching strategies
- [ ] Add database tuning suggestions
- [ ] Include monitoring recommendations

---

### Issue #23: Deployment Documentation
**Priority:** P3 - Low  
**Type:** Documentation  
**Labels:** deployment, operations

**Description:**
Create comprehensive deployment documentation for different environments.

**Acceptance Criteria:**
- [ ] Document Docker deployment setup
- [ ] Add production configuration guidelines
- [ ] Include database migration strategies
- [ ] Add monitoring and logging setup
- [ ] Create environment-specific configurations

## Summary

**Total Issues:** 23  
**Critical (P0):** 3 issues  
**High (P1):** 6 issues  
**Medium (P2):** 8 issues  
**Low (P3):** 6 issues  

**Categories:**
- Compilation Fixes: 3 issues
- Core Features: 8 issues
- Testing: 4 issues
- Documentation: 6 issues
- Polish/Optimization: 2 issues

This comprehensive issue breakdown transforms the README task completion checklist into specific, actionable GitHub issues that can be individually assigned, tracked, and completed.