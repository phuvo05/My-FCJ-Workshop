---
title: "Event 2 - AWS GenAI Builder Club: AI-Driven Development Life Cycle"
weight: 2
chapter: false
---

## AWS GenAI Builder Club: AI-Driven Development Life Cycle - Reimagining Software Engineering

**Date & Time:** Friday, October 3, 2025 | 14:00 (2:00 PM)

**Location:** AWS Event Hall, L26 Bitexco Tower, Ho Chi Minh City

**Instructors:** Toan Huynh & My Nguyen

**Coordinators:** Diem My, Dai Truong, Dinh Nguyen

---

## Event Overview

This AWS GenAI Builder Club gathering investigated the AI-Driven Development Lifecycle (AI-DLC), an innovative methodology for software engineering that incorporates AI as a core collaborator throughout the complete development journey. The session included interactive demonstrations of Amazon Q Developer and Kiro, presenting real-world AI applications in contemporary software development.

---

## Agenda

| Time | Session | Instructor |
|---|---|---|
| 14:00 - 14:15 | Welcoming | - |
| 14:15 - 15:30 | AI-Driven Development Life Cycle Overview & Amazon Q Developer Demonstration | Toan Huynh |
| 15:30 - 15:45 | Break | - |
| 15:45 - 16:30 | Kiro Demonstration | My Nguyen |

---

## Key Concepts & Learnings

### 1. AI-Driven Development Lifecycle (AI-DLC) Overview

#### Core Philosophy

The AI-Driven Development Lifecycle signifies a fundamental transformation in software construction methods. Instead of treating AI as a secondary feature or basic code completion utility, AI-DLC positions AI as an intelligent collaborator throughout the complete development workflow.

**Key Principles:**

- **You Maintain Control** - AI serves as your assistant, not your supervisor. You need to retain decision-making power over project direction and implementation specifics.

- **AI as Partner, Not Substitute** - AI should pose important questions about your project needs, architecture, and objectives. The partnership should flow both ways, with you steering AI recommendations.

- **Design Before Building** - Always develop a thorough plan before writing code. AI can assist in generating this plan, but you must examine, confirm, and improve it.

#### The Development Workflow

**Step 1: Develop a Project Plan**

- Establish clear project requirements and boundaries
- Request AI to produce a plan based on your specifications
- Critically assess the plan and ask for adjustments
- Confirm the plan is thorough and clear

**Step 2: Decompose into User Stories**

- Transform the plan into user stories with explicit acceptance criteria
- Split large scope into smaller, handleable units
- Each unit becomes a mini-project that can be delegated to team members
- Calculate timelines for each unit (while being careful about over-estimation)

**Step 3: Establish Technology Stack**

- Explicitly state the technologies, frameworks, and tools to be utilized
- Rather than instructing AI "don't implement this," say "implement this way"
- Affirmative guidance produces better success rates than negative limitations

**Step 4: Thorough Requirements & Design**

- Document requirements with accuracy and clarity
- Partner with AI to develop detailed specifications
- Specify data models, API contracts, and system architecture
- Produce design documents before implementation starts

**Step 5: Implementation & Confirmation**

- Build features following the plan
- Apply mob development methodology (team works collectively on code)
- Confirm all produced code as a team
- Perform code reviews and quality assessments

**Step 6: Testing & Deployment**

- Progress through environments: Development (Dev) → Testing (QA) → User Acceptance Testing (UAT) → Production (Prod)
- Maintain quality gates at each phase
- Confirm functionality before production release

#### Critical Success Factors

- **Develop a Plan First** - Don't assume AI will manage everything. Always begin with a defined plan.
- **Review Continuously** - Consistently review AI recommendations and outputs. Significant error rates are possible.
- **You Are the Director** - Your worth lies in code validation and project supervision, not in authoring every line of code.
- **Pose Clarifying Questions** - Confirm AI grasps your project context by asking critical questions about requirements, architecture, and objectives.
- **Apply Prompt Templates** - Design structured prompts including user context, user stories, and particular requirements to obtain clearer AI responses.
- **Save Plans to Files** - Request AI to generate plans as files you can store, review, and adjust. This produces a living document for future consultation.
- **Be Courteous to AI** - Preserve respectful communication with AI tools. Positive rapport may benefit future interactions (and it's simply good practice!).

---

### 2. Amazon Q Developer Demonstration

#### What is Amazon Q Developer?

Amazon Q Developer is an AI-enabled assistant that revolutionizes the software development lifecycle (SDLC) through autonomous capabilities across various platforms:

- **AWS Console** - Supports infrastructure and service configuration
- **IDE (Integrated Development Environment)** - Delivers code generation and optimization recommendations
- **CLI (Command Line Interface)** - Supports command generation and automation
- **DevSecOps Platforms** - Incorporates security practices into the development workflow

#### Key Capabilities

**Code Generation & Quality**

- Speeds up code generation with AI-enabled suggestions
- Enhances code quality through smart recommendations
- Preserves smooth integration with current workflows
- Comprehends complex codebases and recommends optimizations

**Documentation & Testing**

- Automatically produces thorough documentation
- Generates unit tests with minimal manual effort
- Considerably improves code maintainability and reliability
- Minimizes boilerplate and repetitive coding tasks

**Intelligent Partnership**

- Functions as an intelligent partner utilizing large language models
- Merges deep AWS service knowledge with coding proficiency
- Assists developers in speeding up development cycles
- Improves code quality and reinforces security stance

**Automation Throughout Development Lifecycle**

- Automates standard tasks throughout the complete development lifecycle
- Decreases manual, repetitive work
- Enables developers to concentrate on higher-value, creative tasks
- Enhances overall productivity and efficiency

#### Best Practices for Using Amazon Q Developer

1. **Supply Clear Context** - Provide Q comprehensive information about your project, architecture, and requirements
2. **Apply Specific Prompts** - Rather than vague requests, deliver specific, detailed prompts with examples
3. **Examine Suggestions** - Always examine Q's suggestions before applying them
4. **Iterate and Improve** - If the initial suggestion isn't ideal, refine your prompt and try again
5. **Utilize AWS Knowledge** - Benefit from Q's deep understanding of AWS services and best practices

---

### 3. Kiro Demonstration

#### What is Kiro?

Kiro is an autonomous IDE (Integrated Development Environment) created by Amazon Web Services that connects rapid AI-powered prototyping and production-ready software development. It's presently in public preview.

#### Core Philosophy

Kiro represents the principle that AI should boost developer productivity while preserving professional standards, clear organization, thorough testing, documentation, and long-term maintainability.

#### Key Features

**Specification-Driven Development**

- When you provide a requirement (e.g., "add a product rating system"), Kiro transforms it into:
  - User stories with explicit acceptance criteria
  - Design documentation
  - Task lists and implementation plans
  - Organized specifications before code generation

**Agent Hooks & Automation**

- Automatically initiates tasks based on events:
  - File saves initiate documentation updates
  - Commits initiate test generation
  - Particular actions initiate performance optimization
  - Minimizes manual, repetitive work

**Steering & Project Context**

- Develop steering files (markdown) to outline:
  - Project structure and arrangement
  - Coding standards and conventions
  - Preferred architecture patterns
  - Team guidelines and best practices
- Assists Kiro in deeply understanding your project context

**Multi-File Analysis & Intent Understanding**

- Examines multiple files concurrently
- Grasps functional goals across the codebase
- Implements changes aligned with overall project objectives
- Extends beyond basic code completion

**VS Code Integration**

- Constructed on VS Code's open-source base
- Import settings, themes, and extensions from VS Code
- Recognizable interface for existing VS Code users
- Effortless transition for developers

**Flexible AI Model Selection**

- Presently uses Claude Sonnet 4 as default
- "Auto" mode merges multiple models based on context
- Equilibrium between quality and cost
- Adaptability to select different models for different tasks

#### Advantages of Using Kiro

**Enhanced Transparency & Control**

- Begin with specifications before code generation
- Examine and confirm specs before implementation
- Decrease hallucinated code or misaligned implementations
- Preserve clear traceability from requirements to code

**Decreased Boilerplate & Repetitive Tasks**

- Agent hooks automate documentation generation
- Automatic unit test creation
- Automatic information updates
- Liberates developers for higher-value work

**Security & Privacy**

- Most code operations occur locally
- Data only transmitted externally with explicit permission
- Preserves control over sensitive information

**Extensibility & Flexibility**

- Connects external tools via MCP (Model Context Protocol)
- Supports multiple AI models
- Not restricted to a single AI environment
- Adaptable to different team workflows

#### Limitations & Considerations

- **Preview Status** - Still in public preview; stability and features may change
- **Complex Projects** - May face challenges with deep contextual understanding in highly complex projects
- **Oversight Required** - Users still need to supervise and confirm AI decisions
- **Future Pricing** - Anticipated pricing tiers:
  - Free: ~50 tasks/month
  - Pro: ~1,000 tasks/month
  - Pro+: ~3,000 tasks/month

#### When to Use Kiro

- You desire an AI + programming workflow that preserves professionalism and clear organization
- Constructing rapid prototypes but concerned about production durability
- Investigating how AI can become a genuine programming colleague, not just a code suggestion tool
- You require specification-driven development with automated documentation and testing

---

## Common Pitfalls When Using AI in Development

### 1. Anticipating AI to Manage Everything

**Problem:** Many developers anticipate AI to finish entire projects autonomously.

**Solution:** Always develop a plan first and examine regularly. AI is a tool to boost productivity, not substitute developer judgment.

### 2. Elevated Error Rates

**Problem:** AI can commit mistakes, especially in complex scenarios.

**Solution:** Implement regular examination cycles. Confirm all AI-generated code before deployment.

### 3. Absence of Clear Requirements

**Problem:** Vague or unclear requirements lead to vague AI outputs.

**Solution:** Document requirements with precision. Partner with AI to develop detailed specifications before implementation.

### 4. Negative Constraints Instead of Affirmative Guidance

**Problem:** Instructing AI "don't do this" is less productive than "do this."

**Solution:** Apply positive, specific instructions. Better success rates derive from clear affirmative guidance.

### 5. Inadequate Project Context

**Problem:** AI doesn't comprehend your project's unique requirements and constraints.

**Solution:** Develop steering files, supply detailed context, and pose critical questions to AI about your project.

### 6. Viewing AI as a Director

**Problem:** Permitting AI to make all decisions about project direction and architecture.

**Solution:** Remember: **You are the director.** Your worth lies in code confirmation and project oversight, not in authoring every line of code.

---

## Key Takeaways

1. **AI is Your Assistant** - Preserve control over project decisions and implementation direction

2. **Design First, Code Second** - Always develop a thorough plan before implementation

3. **Partnership Over Automation** - AI should pose questions and partner, not just execute commands

4. **Clear Requirements Matter** - Precision in requirements leads to superior AI outputs

5. **Regular Examination is Essential** - Don't anticipate AI to be perfect; examine and confirm continuously

6. **You Are the Code Director** - Your worth is in confirmation and oversight, not in authoring every line

7. **Apply Structured Prompts** - Templates with context, user stories, and requirements produce better results

8. **Save Plans to Files** - Develop living documents you can consult and adjust

9. **Affirmative Guidance Works Better** - Instruct AI what to do, not what to avoid

10. **Experience Matters** - Apply these tools practically to comprehend their capabilities and limitations

---

## Recommended Tools & Resources

- **Amazon Q Developer** - AI-enabled development assistant integrated with AWS services
- **Kiro IDE** - Specification-driven development environment with AI partnership
- **AWS CodeWhisperer** - Code generation and optimization tool
- **MCP (Model Context Protocol)** - Framework for connecting external tools and services

---

## Conclusion

The AI-Driven Development Lifecycle embodies a new paradigm in software engineering where AI and humans partner as equals. Success demands clear planning, regular examination, precise requirements, and preserving developer control over project direction. Tools such as Amazon Q Developer and Kiro are facilitating this new workflow, but they function best when developers comprehend their capabilities and limitations, and preserve their role as project directors and code validators.
