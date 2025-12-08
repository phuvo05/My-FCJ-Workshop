---
title: "Day 36 - NLP Foundations & Applications"
weight: 1
chapter: false
pre: "<b> 1.8.1. </b>"
---

**Date:** 2025-10-27 (Monday)  
**Status:** "Done"  

---

# **What is Natural Language Processing?**

**Natural Language Processing (NLP)** is a field of Artificial Intelligence that focuses on enabling computers to **understand, interpret, generate, and interact** with human language.

NLP integrates **computational linguistics**, **machine learning**, and **deep learning** to process large-scale text and speech data.

## Typical NLP Tasks:
- Text classification
- Sentiment analysis
- Named Entity Recognition (NER)
- Machine translation
- Part-of-speech (POS) tagging
- Speech recognition

---

# **Core Linguistic Components in NLP**

## **Phonetics – The Sounds of Human Speech**

**Phonetics** studies the *physical* properties of speech sounds.

### Three Branches:
- **Articulatory phonetics**: how sounds are produced (tongue, lips, vocal folds…)
- **Acoustic phonetics**: physical sound properties (frequency, amplitude, duration)
- **Auditory phonetics**: how humans perceive sounds

**NLP Relevance:** Used in speech recognition, speech synthesis (TTS), acoustic modeling.

---

## **Phonology – Sound Systems of Languages**

**Phonology** studies how sounds function **within a particular language**.
It deals with **phonemes**, stress patterns, allowable sound combinations.

**NLP Relevance:** Grapheme-to-phoneme conversion, pronunciation modeling.

---

## **Morphology – Structure of Words**

**Morphology** studies how words are formed from smaller units called **morphemes**.

### Examples:
- Prefixes: un-, re-, pre-
- Suffixes: -ing, -ed, -ness
- Roots/stems: run, happy, form

**NLP Relevance:**
- Stemming
- Lemmatization
- Tokenization
- Vocabulary building for BoW models

---

# **NLP Applications**

## Search Engines
Your daily searches in the search engines are facilitated by NLP for query understanding and result ranking.

### Search Intent Recognition Example
When someone searches for **"glass coffee tables"**, the intent engine determines that the word "glass" likely refers to the value of attribute **'Top Material'** in coffee tables. It then directs the search engine accordingly to show the coffee tables category with the 'Top Material' attribute set to 'glass'.

---

## Online Advertising

NLP enables targeted ads by analyzing online behavior through multiple components:

### 1. Named Entity Recognizer (NER)
Identifies selected information elements called Named Entities (NE). Due to unavailability of labeled data, semi-supervised approaches are adapted to detect project use-case specific entities.

### 2. Relationship Extraction
One of the classical NLP tasks which aims at extracting semantic relationships from unstructured or semi-structured text documents.

### 3. Moment Recognizer (MoRec)
Enables analysts to understand forum discussions in the knowledge discovery phase by processing unstructured discussion text and extracting knowledge in terms of events. Events can be defined and configured depending on the use-case under investigation.

---

## Voice Assistants
Siri, Alexa, and Google Assistant use NLP to understand and respond to your voice commands.

## Machine Translation
Services like Google Translate rely on NLP to convert text from one language to another.

## Chatbots
Customer service chatbots use NLP to interact with users and provide assistance.

## Text Summarization
NLP algorithms can condense long articles into brief summaries.
