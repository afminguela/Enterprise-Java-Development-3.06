# Enterprise Java Development 3.06 - Task Management System

Always reference these instructions first and fallback to search or bash commands only when you encounter unexpected information that does not match the info here.

## Working Effectively

### Bootstrap, Build, and Test the Repository:
Navigate to the `task/` directory for all operations (this is where the Maven project is located):
```bash
cd /home/runner/work/Enterprise-Java-Development-3.06/Enterprise-Java-Development-3.06/task
```

**CRITICAL BUILD TIMING - NEVER CANCEL:**
- Clean compile: `./mvnw clean compile` -- takes 3 seconds. NEVER CANCEL. Set timeout to 60+ seconds.
- Full package build: `./mvnw clean package -DskipTests` -- takes 5 seconds. NEVER CANCEL. Set timeout to 120+ seconds.
- Tests: `./mvnw test` -- takes 8 seconds. NEVER CANCEL. Set timeout to 180+ seconds.
- With tests: `./mvnw clean package` -- takes 10 seconds. NEVER CANCEL. Set timeout to 300+ seconds.

### Run the Application:
- **ALWAYS run the bootstrapping steps first (clean compile).**
- Development mode: `./mvnw spring-boot:run` -- starts in 3 seconds, runs on port 8080
- Production JAR: `java -jar target/task-0.0.1-SNAPSHOT.jar` (after package build)
- Application provides H2 database console at: http://localhost:8080/h2-console
  - JDBC URL: `jdbc:h2:mem:taskdb`
  - Username: `sa`  
  - Password: (empty)

### Prerequisites:
- Java 17 or higher (confirmed working with OpenJDK 17.0.16)
- Maven 3.9+ (use included Maven wrapper `./mvnw`)
- No external database required (uses H2 in-memory database)

## Validation

### Always run these validation steps after making changes:
1. **Compile check**: `./mvnw clean compile`
2. **Test validation**: `./mvnw test` 
3. **Application startup**: `./mvnw spring-boot:run` (verify starts without errors, then Ctrl+C)
4. **Manual validation scenarios**:
   - Start application: `./mvnw spring-boot:run`
   - Verify application starts and shows "Started TaskApplication in X seconds"
   - Verify H2 console message: "H2 console available at '/h2-console'"
   - Verify Tomcat starts: "Tomcat started on port 8080"
   - Access H2 console at http://localhost:8080/h2-console to verify database connectivity
   - Check database schema: Should see `TASKS` table with proper inheritance columns

### Build Artifacts to Check:
- JAR file size: ~57MB (`target/task-0.0.1-SNAPSHOT.jar`)
- Database tables created: `TASKS` with columns for inheritance (task_type, hourly_rate, department, priority)

## Repository Structure

This is a Maven-based Spring Boot 3.5.4 application using Java 17.

### Key Project Structure:
```
task/                                    # Main project directory (work here)
├── src/main/java/com/taskjava/task/
│   ├── TaskApplication.java             # Spring Boot main application  
│   └── models/
│       ├── Task.java                    # Abstract base entity with inheritance
│       ├── BillableTask.java            # Billable task with hourly rate
│       ├── InternalTask.java            # Internal task with department/priority
│       └── TaskPriority.java            # Priority enumeration
├── src/main/resources/
│   └── application.properties           # H2 database configuration
├── src/test/java/com/taskjava/task/
│   └── TaskApplicationTests.java        # Basic Spring Boot test
├── src/test/resources/
│   └── application-test.properties      # Test database configuration
├── pom.xml                              # Maven dependencies and configuration
├── mvnw / mvnw.cmd                      # Maven wrapper (use this)
└── instructions.txt                     # Original exercise requirements
```

### Technologies Used:
- **Spring Boot 3.5.4** - Main framework
- **Spring Data JPA** - Data persistence with Hibernate
- **H2 Database** - In-memory database (runtime and test)
- **Lombok** - Code generation (included but minimal usage)
- **Jakarta Persistence API** - JPA 3.0 specification
- **Maven** - Build and dependency management

## Current Implementation Status

### ✅ Working Features:
- Project builds and compiles successfully
- Maven configuration with all required dependencies
- Task entity hierarchy with single table inheritance (`@Inheritance(strategy = InheritanceType.SINGLE_TABLE)`)
- BillableTask with hourly rate and hours worked
- InternalTask with department and priority enum
- H2 in-memory database with web console
- Basic Spring Boot application that starts successfully
- JPA entity creation and database schema generation
- Basic integration test that validates Spring context loading

### ⚠️ Implementation Notes:
- Uses single table inheritance strategy for Task hierarchy
- All fields use proper Jakarta JPA annotations (not Spring Data annotations)
- H2 database is configured for both runtime and testing
- No custom repositories or services yet (would be next development phase)
- Entity validation is handled by JPA nullable constraints (not Jakarta Validation annotations)

### ❌ Not Yet Implemented (from original requirements):
- PR Company system (Contact and embedded Name entities) 
- SQL vs JPQL comparison documentation
- Custom repository interfaces for data access
- Service layer implementation  
- REST controllers
- Comprehensive business logic and validation

## Common Tasks

### Build Commands Reference:
```bash
# Basic compilation (3 seconds)
./mvnw clean compile

# Run tests only (8 seconds) 
./mvnw test

# Package without tests (5 seconds)
./mvnw clean package -DskipTests

# Full build with tests (10 seconds)
./mvnw clean package

# Clean workspace
./mvnw clean

# Run application in development mode
./mvnw spring-boot:run

# Run packaged JAR
java -jar target/task-0.0.1-SNAPSHOT.jar
```

### Dependencies Management:
```bash
# Check dependency tree
./mvnw dependency:tree

# Download sources and javadocs
./mvnw dependency:sources dependency:resolve -Dclassifier=javadoc
```

### Troubleshooting:
- **Build fails with mixed imports**: Ensure all JPA imports use `jakarta.persistence.*` not `javax.persistence.*`
- **Cannot find symbol errors**: Usually means wrong annotation imports (use JPA annotations, not Spring Data)
- **Application won't start**: Check H2 dependency is present and database configuration in `application.properties`
- **Tests fail**: Verify H2 is in test scope and test configuration is present in `src/test/resources/application-test.properties`

## Development Guidelines

### When Making Changes:
1. **Always work in the `task/` directory**
2. **Run `./mvnw clean compile` after any code changes** 
3. **Run `./mvnw test` to validate changes don't break existing functionality**
4. **Start the application with `./mvnw spring-boot:run` to test runtime behavior**
5. **Use proper Jakarta JPA annotations** (`jakarta.persistence.*`)
6. **Maintain single table inheritance strategy** for Task hierarchy
7. **Add H2 dependency scope appropriately** (runtime for main, test for tests)

### Entity Development Patterns:
- Task entities use single table inheritance with discriminator column
- Use `@Entity`, `@Table`, `@Column` from jakarta.persistence package
- Base Task class is abstract with `@Inheritance(strategy = InheritanceType.SINGLE_TABLE)`
- Subclasses use `@DiscriminatorValue` to specify type
- Follow existing patterns for constructors, getters/setters, and business methods

### Database Access:
- H2 console available at http://localhost:8080/h2-console when application is running
- Default connection: `jdbc:h2:mem:taskdb`, username: `sa`, password: (empty)
- Schema auto-generated from JPA entities with `spring.jpa.hibernate.ddl-auto=create-drop`
- SQL logging enabled with `spring.jpa.show-sql=true`

## Quick Reference

### Essential File Locations:
- Main application: `task/src/main/java/com/taskjava/task/TaskApplication.java`
- Entity models: `task/src/main/java/com/taskjava/task/models/`
- Database config: `task/src/main/resources/application.properties`
- Test config: `task/src/test/resources/application-test.properties`
- Maven config: `task/pom.xml`
- Original requirements: `task/instructions.txt`

### Port and URLs:
- Application: http://localhost:8080
- H2 Console: http://localhost:8080/h2-console
- No REST endpoints implemented yet (just Spring Boot default error page)

### Key Commands Summary:
| Task | Command | Time | Timeout |
|------|---------|------|---------|
| Compile | `./mvnw clean compile` | 3s | 60s |
| Test | `./mvnw test` | 8s | 180s |
| Package | `./mvnw clean package` | 10s | 300s |
| Run | `./mvnw spring-boot:run` | 3s startup | N/A |

Remember: **NEVER CANCEL** any build or test commands. Wait for completion even if they seem slow.