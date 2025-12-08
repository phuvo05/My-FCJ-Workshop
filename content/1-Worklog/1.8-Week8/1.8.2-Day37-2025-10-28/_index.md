---
title: "Day 37 - Voice Search & Chatbot Architecture"
weight: 2
chapter: false
pre: "<b> 1.8.2. </b>"
---

**Date:** 2025-10-28 (Tuesday)  
**Status:** "Done"  

---

# **Voice Search (How Siri Works)**

Voice search systems follow a pipeline from speech input to actionable response:

## Pipeline Components:

### 1. Analog to Digital Conversion
Speech (utterance) → Sound wave pattern → Spectrogram (frequency pattern) → Sequence of acoustic frames using **Fast Fourier Transform (FFT)**

### 2. Automatic Speech Recognition (ASR)
- **Feature analysis**: Extract acoustic features
- **Hidden Markov Model (HMM)**: Pattern recognition for speech-to-text
- **Viterbi algorithm**: Find most likely sequence of hidden states
- **Phonetic dictionary**: Map sounds to words
- **Language model**: Ensure grammatical correctness

### 3. NLP Annotation
- Tokenization
- POS tagging
- Named Entity Recognition (NER)

### 4. Pattern-Action Mappings
Map recognized intents to appropriate actions

### 5. Service Manager
- Internal & external APIs (email, SMS, maps, weather, stocks, etc.)
- Execute the requested action

### 6. Text-to-Speech (TTS)
Convert response back to speech

### 7. User Feedback
System learns from corrections to improve accuracy

---

# **Voicebot Architecture**

The voicebot processing pipeline consists of multiple linguistic levels:

## Processing Layers:

### Speech Analysis (Phonology)
Recognize and transcribe speech using Automatic Speech Recognition (ASR)

### Morphological and Lexical Analysis (Morphology)
Analyze word structure and meaning using morphological rules and lexicon

### Parsing (Syntax)
Understand sentence structure using lexicon and grammar rules

### Contextual Reasoning (Semantics)
Understand meaning in context using discourse context

### Application Reasoning and Execution (Reasoning)
Use domain knowledge to decide actions

### Utterance Planning
Plan what to say in response

### Syntactic Realization
Generate grammatically correct sentences

### Morphological Realization
Apply correct word forms

### Pronunciation Model
Generate proper pronunciation

### Speech Synthesis
Convert text back to speech

---

# **Chatbot Workflow**

## Step-by-Step Process:

### 1. User → Chat Client
User types: *"I want to check my account balance."*
Chat Client = interface where user types (web, app, messenger)

### 2. Chat Client → Chatbot
Message sent to chatbot system

### 3. Chatbot → NLP Engine
Chatbot sends message to NLP Engine for analysis

#### NLP Engine performs two main tasks:

**(a) Intent Detection**
Determine what the user wants to do
- Example: `check_balance`

**(b) Entity Extraction**
Extract important data from the sentence
- Example: `account = checking/savings?`

### 4. NLP Engine → Business Logic / Data Services
Based on **intent**, chatbot calls the appropriate service:
- Query database
- Call API
- Execute business rules
- Process backend logic

Example: Call API to get balance from banking system

### 5. Data Services → Chatbot
Backend returns result:
> "Your account balance is $12,500.00"

### 6. Chatbot → Chat Client
Chatbot packages information into natural language response

### 7. Display to User
User sees the response

---

## Chatbot = Listening + Chatting

### Listening (NLP - Understanding)
- Intent recognition
- Entity extraction
- Context understanding

### Chatting (NLG - Generation)
- Natural language generation
- Response formulation
- Personalization

### Behind the Scenes:
- **Knowledge-based data**: Facts, rules, FAQs
- **Machine learning**: Learning from interactions
- **Business logic**: Application-specific rules

---

## Important Distinction: Keyword vs Entity

**Keywords** = words that indicate topics or subjects
**Entities** = specific data points with types and values

Example: *"Book a flight to Paris on Friday"*
- Keywords: book, flight
- Entities: 
  - destination = "Paris" (LOCATION)
  - date = "Friday" (DATE)

Not all keywords are entities, but all entities are extracted from keywords!
