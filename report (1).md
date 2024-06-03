---
## Front matter
title: "Research work"
subtitle: "Mass Service Systems with Join-the-Shortest-Queue Policy: Description of Problem-Solving Methods"
author: "Morozov Mikhail Evgenievich"

## Generic options
lang: ru-RU
toc-title: "Table of contents"

## Bibliography
bibliography: bib/cite.bib
csl: pandoc/csl/gost-r-7-0-5-2008-numeric.csl

## Pdf output format
toc: true # Table of contents
toc-depth: 2
lof: false # List of figures
lot: false # List of tables
fontsize: 12pt
linestretch: 1.5
papersize: a4
documentclass: scrreprt

## I18n polyglossia
polyglossia-lang:
  name: russian
  options:
	- spelling=modern
	- babelshorthands=true
polyglossia-otherlangs:
  name: english
## I18n babel
babel-lang: russian
babel-otherlangs: english
## Fonts
mainfont: PT Serif
romanfont: PT Serif
sansfont: PT Sans
monofont: PT Mono
mainfontoptions: Ligatures=TeX
romanfontoptions: Ligatures=TeX
sansfontoptions: Ligatures=TeX,Scale=MatchLowercase
monofontoptions: Scale=MatchLowercase,Scale=0.9
## Biblatex
biblatex: true
biblio-style: "gost-numeric"
biblatexoptions:
  - parentracker=true
  - backend=biber
  - hyperref=auto
  - language=auto
  - autolang=other*
  - citestyle=gost-numeric
## Pandoc-crossref LaTeX customization
figureTitle: "Рис."
tableTitle: "Таблица"
listingTitle: "Листинг"
lofTitle: "Список иллюстраций"
lotTitle: "Список таблиц"
lolTitle: "Листинги"
## Misc options
indent: true
header-includes:
  - \usepackage{indentfirst}
  - \usepackage{float} # keep figures where there are in the text
  - \floatplacement{figure}{H} # keep figures where there are in the text
---

## Introduction

### 1. Relevance of the Topic

In the modern world, where the amount of processed information and the number of users constantly grow, it is important to understand the significance of mass service systems (MSS) as they enable various technologies and infrastructures to operate efficiently. It is also crucial to recognize the necessity for improvements and optimizations in these systems under conditions of high competition and demanding user requirements.

For instance, in the study “Analysis of Join-the-Shortest-Queue Routing for Web Server Farms” by Varun Gupta, Mor Harchol-Balter, Karl Sigman, and Ward Whitt, it is noted that MSS in the communication sector face continuous load increases. Proper management, such as the use of the Join-the-Shortest-Queue (JSQ) policy, can reduce response wait times and improve overall service quality. JSQ is particularly important for "server farms" as they handle vast amounts of web requests. The main idea of JSQ is to evenly distribute the load among servers, preventing overloads and enhancing response times. JSQ can be applied not only in IT but also in other fields like manufacturing and logistics. Thus, researching the JSQ policy is highly relevant as it helps manage increasing loads and demands for speed and service quality.

### 2. Research Objectives and Tasks

The objective of this work is to investigate mass service systems with the JSQ policy. This study includes:

1. Examination of existing methods for solving these issues.
2. Evaluation of the effectiveness of these methods.

### 3. List of Tasks

To achieve the stated objective, several specific tasks need to be addressed:

1. Investigate existing methods and models: This includes studying their advantages and disadvantages, as well as the conditions under which they work most effectively.
2. Analyze these methods and models: This involves identifying the advantages and disadvantages of the methods and models mentioned above.

## Chapter 1. Theoretical Foundations of Mass Service Systems and the Join-the-Shortest-Queue (JSQ) Policy

### 1. Basic Concepts and Definitions

Mass service systems describe the process of servicing clients in various fields. These systems help understand how to optimize service and minimize client wait times. They include components such as request flows, queues, service devices, which interact according to specific rules, and service parameters like processing speed and wait times.

Simply put, an MSS is any system designed to handle a flow of requests. The serviced object in such a system is often a request for fulfilling a need, such as airplane boarding or ticket purchasing. The devices servicing these requests are called service devices or service channels. These include telephone lines, runways, repairmen, ticket sellers, loading/unloading points at bases and warehouses, hotels, and carriers.

#### 1.1 Request Flows

In this subsection, we will look at different types of request flows. A request flow is Poissonian if three conditions are met:

1. The probability of an event (request arrival) over a short time interval is proportional to the length of that interval.
2. The probability of two events occurring over a short interval is negligibly small.
3. The probability of a request arrival does not depend on previous events.

The intensity of the event flow ($λ$) is the average number of events per unit of time. A flow is stationary if its probabilistic characteristics do not depend on time, meaning the intensity $λ$ of a stationary flow is constant. A flow is said to be without consequences if for any two non-overlapping time intervals $τ1$ and $τ2$, the number of events in one interval does not depend on the number in the other. This means events in the flow occur independently. A flow is ordinary if events occur singly rather than in groups. A flow is simplest (or stationary Poissonian) if it has all three properties:

1. Event probability over a short interval is proportional to the interval's length.
2. Probability of two events over a short interval is negligibly small.
3. Probability of a request arrival is independent of previous events.

#### 1.2 Main Parameters of MSS

The main parameters determining MSS efficiency include request flow intensity ($λ$), service speed ($μ$), queue length, and wait time. Service speed ($μ$) is the average number of requests the system can handle per unit time. A high service speed means the system can process more requests in a given time. Queue length is the number of requests waiting for service in the system, which varies with request flow intensity and service speed. Wait time is the average time a request spends in the queue before being serviced, important for evaluating service efficiency and user satisfaction.

### 2. Join-the-Shortest-Queue (JSQ) Policy

#### 2.1 JSQ Policy Operation Principle

The JSQ policy aims to minimize client wait times by directing new requests to the shortest queue. Foley R.D. and McDonald D.R. in their work “Join the shortest queue: stability and exact asymptotics” describe how this policy operates. When a new request enters the system, it compares the lengths of all available queues and joins the shortest one.

#### 2.2 JSQ Policy Advantages and Disadvantages

One major advantage is reduced client wait times. By directing requests to the shortest queues, the system minimizes the chances of long queues and overloads. JSQ also promotes an even load distribution among servers, increasing their longevity and reducing failure risks.

However, there are disadvantages. Masahiro Kobayashi, Yutaka Sakuma, and Masakiyo Miyazawa in their study “Join the shortest queue among k parallel queues: tail asymptotics of its stationary distribution” state that JSQ can be ineffective under high load variability. Frequent changes in queue lengths can increase decision-making time and cause additional delays. Moreover, JSQ requires constant queue monitoring, raising computational costs and complicating system implementation. JSQ does not account for specific server characteristics like processing speed or task priorities, which may lead to inefficient resource use in systems with heterogeneous servers.

## Chapter 2. Modeling Mass Service Systems with the JSQ Policy

### 1. Mathematical Models of MSS with JSQ

#### 1.1 Markov Models

Markov models are key tools for analysis, providing a detailed description of system behavior using probabilistic transitions between states. Ivo Adan in his study $“The shortest queue problem”$ offers a clear and detailed explanation of Markov models for JSQ. Markov models assume that the system's future state depends only on its current state, making them useful for modeling queue dynamics and load distribution. These models consider various system behaviors like wait time distribution, service frequency, and request flow intensity.

#### 1.2 Models with Heterogeneous Servers

When considering MSS with the JSQ policy, it is important to note that not all servers may be identical. Servers often have different request processing speeds, adding complexity to modeling and optimization. In systems where each server has its own unique service speed, the time needed to process the same request can vary significantly depending on the server. Such heterogeneity requires more complex queue management. JSQ policy in heterogeneous environments demands additional mechanisms to account for server performance differences.

One key idea is using weights for different servers. Each server receives a weight proportional to its service speed, allowing the system to adapt dynamically to current load and server performance. For example, if one server processes requests twice as fast as another, it receives more requests. Stability is another crucial aspect; heterogeneous servers can lead to instability if the request distribution

 policy does not account for performance differences. Methods like adaptive weight regulation based on current load and queue states help maintain stable system operation despite significant request intensity fluctuations.

### 2. Systems of Equilibrium Equations

#### 2.1 Building Equations for Describing System's Stationary States

To analyze MSS, it is important to understand how the system achieves its stationary state, characterized by stable queue length distribution and service intensity, enabling accurate performance forecasts. In a system with multiple servers, each serving one queue, the probability of being in any possible state remains constant over time. Achieving this requires balanced incoming and outgoing request flows for each state, described by equilibrium equations.

For instance, in a system with two queues and three possible queue lengths (0, 1, 2), the possible states are (00), (01), (10), (11), (20), (02), (21), (12), and (22). For each state, the flow of requests entering and leaving the state is determined. Equilibrium equations are formulated for each state, linking the probability of the system being in a given state with the probabilities of other states, considering transitions between them.

For example, for state (11), the equilibrium equation might be:
$$\lambda P(01) + \lambda P(10) = \mu P(11) + \mu P(11)$$

where $\lambda$ is the request arrival intensity, $\mu$ is the service speed, and $P(ij)$ is the probability of the system being in state (ij). Such equations are composed for all possible system states. Solving the linear system of equations provides stationary probabilities for each state, determining key system characteristics.


#### 2.2 Solving Equation Systems for Different MSS Configurations

In systems with infinite buffers, each server can handle an unlimited number of requests, simplifying some aspects of analysis. Standard linear algebra methods can be used to solve equilibrium equations, with the key being the correct determination of incoming and outgoing flow intensities for each state. In infinite systems, the probability of queue overflow is zero, simplifying mathematical calculations and allowing focus on optimizing other parameters. Discrete event simulation, a method imitating system operation where events occur at random times, is particularly useful for analyzing systems with random event timings, such as request arrivals and processing. The Monte Carlo method helps estimate the probability of various outcomes and system behavior under uncertainty.

### 3. Analysis of Characteristics of Systems with Infinite Buffers

Varun Gupta and colleagues in their study “Analysis of Join-the-Shortest-Queue Routing for Web Server Farms” analyze such systems, presenting their numerical experiment results. One key metric they analyzed was the average request wait time in the system. Results showed that using JSQ policy significantly reduces average wait time compared to other load distribution strategies. This is because JSQ effectively balances the load among all available servers, preventing long queues. They also studied queue length distribution, finding that with infinite buffers, the probability of very long queues is extremely low, as JSQ ensures even request distribution. Their experiments also showed that even under high loads, the system remains stable.

### 4. Analysis of Characteristics of Systems with Finite Buffers

In systems with finite buffers, analyzing system behavior becomes even more critical. Satheesh Abimannan in his study conducts numerical experiments to evaluate the performance of such systems.

In section 8 of their work, they detail their findings:

1. Queue Overflow Probability: Results showed that using JSQ policy significantly reduces the queue overflow probability.
2. Service Denial Probability: The probability of service denial is minimal due to even load distribution, enhancing system reliability.
3. Average Wait Time: JSQ minimizes average wait time even with limited queue capacity.

Numerical experiment results for both infinite and finite buffer systems accurately predict system behavior. However, slight discrepancies occur, often due to simplifications in theoretical models that do not account for all real system variations and dynamics. Another important aspect is the probability of rare events, such as queue overflows or service denials. Theoretical models often rely on average values and may underestimate such event probabilities. Numerical simulations provide more accurate estimates for these probabilities. Combining theoretical and numerical approaches offers a more comprehensive view and helps develop more effective MSS management strategies.

## Chapter 4. Practical Applications and Recommendations

### 1. Application of JSQ Policy in Real Systems

The JSQ policy is widely used in various fields due to its efficiency in load distribution and wait time minimization. Another example is in telecommunications networks, where it is important to ensure continuous and reliable service for a large number of users. These systems must prevent node overloads by directing new connections to less loaded servers or routers, improving connection quality and reducing service denial probability.

### 2. Future Research Prospects

Research and development of the JSQ policy continue, with numerous directions for future studies. One key area is studying the impact of new technologies like machine learning and artificial intelligence on JSQ efficiency. These technologies can provide new tools for load prediction and real-time policy adaptation. Another promising direction is researching hybrid systems combining JSQ with other queue management methods. For example, hybrid systems could use JSQ for basic load distribution and then apply other methods for optimizing critical service tasks.

## Conclusion

Research on mass service systems (MSS) with the Join-the-Shortest-Queue (JSQ) policy has shown that this policy is an effective tool for optimizing load distribution and minimizing wait times. The work analyzed both theoretical models and numerical experiment results, leading to several key conclusions. JSQ demonstrates high performance in both infinite and finite buffer systems. In infinite systems, average wait times and the probability of long queues significantly decrease due to even request distribution among servers. In finite buffer systems, the JSQ policy efficiently manages resources and minimizes queue overflow probability, confirmed by numerical experiment results.
