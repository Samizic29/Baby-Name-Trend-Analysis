# 👶 Baby Name Trend Analysis

## Introduction

This project explores **baby naming trends in the United States** across three decades using data from the U.S. Social Security Administration (SSA). The goal is to identify **patterns, shifts in popularity, regional differences**, and uncover interesting name trends over time.

---

## 📊 About the Data

The dataset contains baby name records from **1980 to 2009** and includes:

### **Tables**
| Table | Description |
|------|-------------|
| **names** | Contains baby names, gender, state, and birth year. |
| **regions** | Maps each U.S. state to its corresponding region. |

---

## 🎯 Project Objectives

- Analyze **trends and patterns** in baby name popularity over time.
- Compare **name popularity across decades**.
- Evaluate **regional differences** in naming choices.
- Explore **unique and androgynous names**.
- Identify **shortest and longest popular names**.

---

## 🛠️ Data Preparation

- Imported CSV files using **MySQL Workbench**.
- Created custom schema and executed data cleaning/transformations.
- Performed analysis using Common table expressions, SQL aggregate, window, and join operations.

---

## 🔍 Exploratory Data Analysis

**1. Trends in Popularity**
- Total number of **distinct baby names**.
- **Top male and female names** across years.
- Names with the **largest popularity increase**.

**2. Comparison Across Decades**
- **Top 3 boy and girl names** over the years and decade (1980s, 1990s, 2000s).

**3. Regional Name Popularity**
- Total babies born per region.
- Most common names across **South, Northeast, Midwest, and West**.

**4. Unique and Androgynous Names**
- Top **androgynous names** (names given to both genders).
- Most popular **short** and **long** names.

---

## 🧠 Key Insights

| Insight | Summary |
|--------|---------|
| **Most Popular Names** | *Michael* (boys) and *Jessica* (girls) were the most popular overall. |
| **Decade Leaders** | *Michael* dominated from 1980–1999, while *Jacob* led 2000–2009. |
| **Female Popularity Shift** | *Emily* held the longest female popularity streak (1996–2007). |
| **Fastest Rising Name** | *Colton* showed the **largest increase** in popularity over time. |
| **Regional Patterns** | The **South and Midwest** had the highest birth counts. |
| **Androgynous Names** | *Michael* and *Christopher* appeared frequently across genders. |
| **Name Length** | Shortest popular name: **TY**. Longest: **Francisco Javier**. |

---

## 💡 SQL Concepts & Functions Used

- `JOIN` (inner & left joins)
- `GROUP BY` and `ORDER BY`
- `Aggregrate Functions`
- `Window Function`
- `Common Table Expressions and Sub-Queries`
- `CASE WHEN` conditional logic

---

## ✅ Conclusion

Baby naming trends reveal more than just name choices — they reflect cultural shifts, generational influence, and regional identity. Across the three decades analyzed, **Michael and Jessica shaped naming culture**, while new names rose with changing social preferences. This analysis highlights how data can capture societal identity, trends, and evolution across time.


## 👤 Author

**Samuel Oyedele**  
Data Analyst | Visualization & Insights  
📧 samueloyedele15@gmail.com  
🔗 [LinkedIn](https://www.linkedin.com/in/samuel-oyedele-53579b19b/)

