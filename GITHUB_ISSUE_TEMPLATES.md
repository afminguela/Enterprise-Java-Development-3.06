# GitHub Issue Templates

This directory contains templates that can be used to create GitHub issues from the comprehensive issue list in ISSUES.md.

## How to Use These Templates

1. Copy the template content below for each issue
2. Create a new GitHub issue
3. Paste the template content
4. Fill in the specific details for that issue
5. Add appropriate labels and assignees

## Template for Critical Issues (P0)

```markdown
**Priority:** P0 - Critical  
**Type:** Bug/Task  
**Labels:** [add relevant labels]

## Description
[Brief description of the issue]

## Current Problem
[Description of current errors or problems]

## Acceptance Criteria
- [ ] [Specific requirement 1]
- [ ] [Specific requirement 2]
- [ ] [Specific requirement 3]

## Technical Details
[Any technical specifications or implementation notes]

## Files to Update/Create
- [List of files that need to be modified]

## Definition of Done
- [ ] Code changes implemented
- [ ] Project compiles without errors
- [ ] Tests pass
- [ ] Code reviewed
- [ ] Documentation updated (if applicable)

## Dependencies
[List any issues this depends on or blocks]
```

## Template for Feature Issues (P1-P2)

```markdown
**Priority:** [P1/P2] - [High/Medium]  
**Type:** Feature/Enhancement  
**Labels:** [add relevant labels]

## Description
[Detailed description of the feature to implement]

## User Story
As a [type of user], I want [goal] so that [benefit/value].

## Acceptance Criteria
- [ ] [Specific functional requirement 1]
- [ ] [Specific functional requirement 2]
- [ ] [Specific functional requirement 3]

## Technical Requirements
[Technical specifications and implementation details]

## Files to Create/Update
- [List of new files to create]
- [List of existing files to modify]

## Testing Requirements
- [ ] Unit tests created
- [ ] Integration tests (if applicable)
- [ ] Manual testing completed

## Definition of Done
- [ ] Feature implemented according to requirements
- [ ] Tests pass with good coverage
- [ ] Code reviewed
- [ ] Documentation updated
- [ ] Feature manually verified

## Related Issues
[Links to related issues or dependencies]
```

## Template for Documentation Issues (P3)

```markdown
**Priority:** P3 - Low  
**Type:** Documentation  
**Labels:** documentation

## Description
[What documentation needs to be created or updated]

## Scope
[What should be covered in the documentation]

## Acceptance Criteria
- [ ] [Specific documentation requirement 1]
- [ ] [Specific documentation requirement 2]
- [ ] [Specific documentation requirement 3]

## Target Audience
[Who will be reading this documentation]

## Format Requirements
[Markdown, JavaDoc, etc.]

## Files to Create/Update
- [List of documentation files]

## Definition of Done
- [ ] Documentation written and reviewed
- [ ] Examples included (if applicable)
- [ ] Links and references verified
- [ ] Spelling and grammar checked

## Related Issues
[Links to features this documents]
```

## Sample Issue Creation Script

Here's a sample bash script that could be used to create issues programmatically (requires GitHub CLI):

```bash
#!/bin/bash

# Create Issue #1: Fix Jakarta/Javax Import Conflicts
gh issue create \
  --title "Fix Jakarta/Javax Import Conflicts" \
  --body "**Priority:** P0 - Critical
**Type:** Bug
**Labels:** compilation-error, dependencies

## Description
The project currently has compilation errors due to mixed javax and jakarta imports. All imports should use jakarta.persistence.* consistently for Spring Boot 3.x compatibility.

## Current Errors
- \`package javax.persistence does not exist\`
- \`package javax.validation.constraints does not exist\`

## Acceptance Criteria
- [ ] Replace all \`javax.persistence.*\` imports with \`jakarta.persistence.*\`
- [ ] Replace all \`javax.validation.*\` imports with \`jakarta.validation.*\`
- [ ] Project compiles without import-related errors
- [ ] All entity annotations work correctly

## Files to Update
- \`src/main/java/com/taskjava/task/models/Task.java\`
- \`src/main/java/com/taskjava/task/models/BillableTask.java\`
- \`src/main/java/com/taskjava/task/models/InternalTask.java\`" \
  --label "bug,compilation-error,dependencies,P0" \
  --assignee "@me"

# Add more issue creation commands here...
```

## Labels to Use

### Priority Labels
- `P0` - Critical
- `P1` - High  
- `P2` - Medium
- `P3` - Low

### Type Labels
- `bug` - Something that's broken
- `feature` - New functionality
- `enhancement` - Improvement to existing feature
- `documentation` - Documentation changes
- `testing` - Test-related work

### Component Labels
- `compilation-error` - Build/compilation issues
- `dependencies` - Dependency management
- `jpa-annotations` - JPA/Hibernate annotations
- `jpa-inheritance` - Entity inheritance
- `validation` - Data validation
- `repository` - Data access layer
- `service-layer` - Business logic layer
- `embedded-entity` - Embedded entities
- `unit-tests` - Unit testing
- `integration-tests` - Integration testing

### Status Labels
- `blocked` - Cannot proceed
- `in-progress` - Currently being worked on
- `needs-review` - Ready for code review
- `ready-for-test` - Ready for testing

This template system ensures consistent issue creation and helps maintain organization across the project development lifecycle.