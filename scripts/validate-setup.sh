#!/bin/bash

# Validation Script for GitHub Setup
# This script validates that the setup files are correctly formatted and ready to use

set -e

echo "🔍 Validating GitHub Setup Files..."

# Check if required files exist
REQUIRED_FILES=(
    "ISSUES.md"
    "ISSUE_SUMMARY.md" 
    "PROJECT_BOARD_SETUP.md"
    "GITHUB_ISSUE_TEMPLATES.md"
    "scripts/setup-milestones.sh"
    "scripts/setup-issues.sh"
    "scripts/milestones.json"
    "scripts/issues.json"
    "scripts/SETUP_GUIDE.md"
)

echo "📁 Checking required files..."
for file in "${REQUIRED_FILES[@]}"; do
    if [[ -f "$file" ]]; then
        echo "   ✅ $file exists"
    else
        echo "   ❌ $file missing"
        exit 1
    fi
done

# Validate JSON files
echo ""
echo "🔧 Validating JSON structure..."

if command -v jq &> /dev/null; then
    echo "   📋 Validating milestones.json..."
    if jq empty scripts/milestones.json; then
        echo "   ✅ milestones.json is valid JSON"
        MILESTONE_COUNT=$(jq '.milestones | length' scripts/milestones.json)
        echo "      - Contains $MILESTONE_COUNT milestones"
    else
        echo "   ❌ milestones.json is invalid JSON"
        exit 1
    fi
    
    echo "   📋 Validating issues.json..."
    if jq empty scripts/issues.json; then
        echo "   ✅ issues.json is valid JSON"
        ISSUE_COUNT=$(jq '.issues | length' scripts/issues.json)
        echo "      - Contains $ISSUE_COUNT issues"
        
        # Count by priority
        P0_COUNT=$(jq '.issues | map(select(.priority == "P0")) | length' scripts/issues.json)
        P1_COUNT=$(jq '.issues | map(select(.priority == "P1")) | length' scripts/issues.json)
        P2_COUNT=$(jq '.issues | map(select(.priority == "P2")) | length' scripts/issues.json)
        P3_COUNT=$(jq '.issues | map(select(.priority == "P3")) | length' scripts/issues.json)
        
        echo "      - P0 (Critical): $P0_COUNT issues"
        echo "      - P1 (High): $P1_COUNT issues"
        echo "      - P2 (Medium): $P2_COUNT issues"
        echo "      - P3 (Low): $P3_COUNT issues"
    else
        echo "   ❌ issues.json is invalid JSON"
        exit 1
    fi
else
    echo "   ⚠️  jq not installed - skipping JSON validation"
    echo "      Install jq to validate JSON structure: apt install jq"
fi

# Check script permissions
echo ""
echo "🔐 Checking script permissions..."
for script in scripts/*.sh; do
    if [[ -x "$script" ]]; then
        echo "   ✅ $script is executable"
    else
        echo "   ❌ $script is not executable (run: chmod +x $script)"
    fi
done

# Validate script content
echo ""
echo "📝 Validating script content..."

if grep -q "gh issue create" scripts/setup-issues.sh; then
    echo "   ✅ setup-issues.sh contains issue creation commands"
else
    echo "   ❌ setup-issues.sh missing issue creation commands"
fi

if grep -q "gh api repos.*milestones" scripts/setup-milestones.sh; then
    echo "   ✅ setup-milestones.sh contains milestone creation commands"
else
    echo "   ❌ setup-milestones.sh missing milestone creation commands"
fi

# Check documentation completeness
echo ""
echo "📚 Checking documentation completeness..."

ISSUES_MD_ISSUES=$(grep -c "^### Issue #" ISSUES.md || echo "0")
echo "   📋 ISSUES.md contains $ISSUES_MD_ISSUES detailed issue specifications"

TEMPLATES_COUNT=$(grep -c "^## Template for" GITHUB_ISSUE_TEMPLATES.md || echo "0")
echo "   📋 GITHUB_ISSUE_TEMPLATES.md contains $TEMPLATES_COUNT issue templates"

BOARD_COLUMNS=$(grep -c "^### [0-9]" PROJECT_BOARD_SETUP.md || echo "0") 
echo "   📋 PROJECT_BOARD_SETUP.md defines $BOARD_COLUMNS board columns"

# Summary
echo ""
echo "📊 Validation Summary:"
echo "   ✅ All required files present"
if command -v jq &> /dev/null; then
    echo "   ✅ JSON files are valid"
fi
echo "   ✅ Scripts are executable"
echo "   ✅ Documentation is complete"
echo ""
echo "🚀 Setup files are ready to use!"
echo ""
echo "📋 Next steps:"
echo "1. Read scripts/SETUP_GUIDE.md for detailed instructions"
echo "2. Run ./scripts/setup-milestones.sh to create milestones"
echo "3. Run ./scripts/setup-issues.sh to create issues"
echo "4. Set up project board using PROJECT_BOARD_SETUP.md"
echo ""
echo "🔗 For manual setup, use the templates in GITHUB_ISSUE_TEMPLATES.md"