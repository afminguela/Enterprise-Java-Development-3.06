#!/bin/bash

# GitHub Milestones Setup Script
# This script creates the 4 milestones for the Enterprise Java Development 3.06 project
# Requires GitHub CLI (gh) to be installed and authenticated

set -e

echo "🚀 Setting up GitHub Milestones for Enterprise Java Development 3.06..."

# Check if gh CLI is available
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) is not installed. Please install it first:"
    echo "   Visit: https://cli.github.com/"
    exit 1
fi

# Check if authenticated
if ! gh auth status &> /dev/null; then
    echo "❌ Not authenticated with GitHub. Please run: gh auth login"
    exit 1
fi

echo "✅ GitHub CLI is ready"

# Get repository info
REPO=$(gh repo view --json owner,name --jq '.owner.login + "/" + .name')
echo "📁 Working with repository: $REPO"

# Function to create milestone
create_milestone() {
    local title="$1"
    local description="$2" 
    local due_date="$3"
    
    echo "📌 Creating milestone: $title"
    
    if [ -n "$due_date" ]; then
        gh api repos/$REPO/milestones \
            --method POST \
            --field title="$title" \
            --field description="$description" \
            --field due_on="$due_date" \
            --field state="open" > /dev/null
    else
        gh api repos/$REPO/milestones \
            --method POST \
            --field title="$title" \
            --field description="$description" \
            --field state="open" > /dev/null
    fi
    
    echo "   ✅ Created: $title"
}

# Calculate dates (adjust as needed based on project start date)
WEEK1_DATE=$(date -d "+1 week" --iso-8601)
WEEK2_DATE=$(date -d "+2 weeks" --iso-8601)
WEEK3_DATE=$(date -d "+3 weeks" --iso-8601)
WEEK4_DATE=$(date -d "+4 weeks" --iso-8601)

echo "📅 Milestone due dates:"
echo "   Week 1: $WEEK1_DATE"
echo "   Week 2: $WEEK2_DATE" 
echo "   Week 3: $WEEK3_DATE"
echo "   Week 4: $WEEK4_DATE"

# Create Milestone 1: Working Baseline
create_milestone \
    "Milestone 1: Working Baseline" \
    "Fix all compilation errors and get project building successfully. This includes resolving Jakarta/javax import conflicts, fixing JPA annotation issues, and ensuring the project compiles and runs.

**Success Criteria:**
- Project compiles without errors
- Basic tests pass
- Application starts successfully
- All validation annotations work correctly

**Issues:** #1, #2, #3, #4, #5" \
    "$WEEK1_DATE"

# Create Milestone 2: Core Task Management
create_milestone \
    "Milestone 2: Core Task Management" \
    "Complete the task management system with repositories, services, and comprehensive testing. Implement full CRUD operations and business logic for both BillableTask and InternalTask entities.

**Success Criteria:**
- Task CRUD operations work
- Repository layer complete with custom queries
- Service layer implemented with business logic
- Comprehensive unit and integration tests
- Inheritance strategy documented

**Issues:** #6, #7, #8, #9, #10" \
    "$WEEK2_DATE"

# Create Milestone 3: Contact Management System
create_milestone \
    "Milestone 3: Contact Management System" \
    "Implement the PR company contact system with embedded Name entities. This demonstrates advanced JPA concepts including embedded entities and complex queries.

**Success Criteria:**
- Contact entities implemented with embedded Name
- Repository layer with embedded field queries
- Service layer for contact management
- Integration tests for embedded functionality
- Verify embedded fields are not stored in separate tables

**Issues:** #11, #12, #13, #14, #15" \
    "$WEEK3_DATE"

# Create Milestone 4: Documentation Complete
create_milestone \
    "Milestone 4: Documentation Complete" \
    "Complete all documentation requirements including SQL vs JPQL analysis, comprehensive code documentation, and deployment guides. This milestone focuses on knowledge transfer and production readiness.

**Success Criteria:**
- SQL vs JPQL analysis complete with examples
- Comprehensive JavaDoc documentation
- Deployment and configuration guides
- Performance optimization recommendations
- Example data and use cases documented

**Issues:** #16, #17, #18, #19, #20, #21, #22, #23" \
    "$WEEK4_DATE"

echo ""
echo "🎉 All milestones created successfully!"
echo ""
echo "📋 Next steps:"
echo "1. Run ./setup-issues.sh to create the issues"
echo "2. Set up project board using PROJECT_BOARD_SETUP.md guidance"
echo "3. Assign issues to milestones"
echo "4. Start with Milestone 1 (critical compilation fixes)"
echo ""
echo "📊 View milestones: https://github.com/$REPO/milestones"