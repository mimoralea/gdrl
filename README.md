# Grokking Deep Reinforcement Learning

**Note:** At the moment, only running the code from the [docker](https://github.com/docker/docker-ce) container (below) is supported. Docker allows for creating a single environment that is more likely to work on all systems. Basically, I install and configure all packages for you, except docker itself, and you just run the code on a tested environment. 

To install docker, I recommend a web search for "installing docker on \<your os here>". For running the code on a GPU, you have to additionally install [nvidia-docker](https://github.com/NVIDIA/nvidia-docker). NVIDIA Docker allows for using a host's GPUs inside docker containers. After you have docker (and nvidia-docker if using a GPU) installed, follow the three steps below. 

## Running the code
  0. Get this repo: `git clone --depth 1 https://github.com/mimoralea/gdrl.git && cd gdrl`
  1. Pull the gdrl image with: `docker pull mimoralea/gdrl:v0.12`
  2. Spin up a container: `docker run -it --rm -p 8888:8888 -v "$PWD"/notebooks/:/mnt/notebooks/ mimoralea/gdrl:v0.12` (remember to use `nvidia-docker` if you are using a GPU.)
  3. Open a browser and go to the URL shown in the terminal (likely to be: http://localhost:8888). The password is: `gdrl`

## About the book

### Book's website

https://www.manning.com/books/grokking-deep-reinforcement-learning

### Table of content

  1. [Introduction to deep reinforcement learning](#1-introduction-to-deep-reinforcement-learning)
  2. Mathematical foundations of reinforcement learning
  3. Balancing immediate and long-term goals
  4. Balancing the gathering and utilization of information
  5. Evaluating agents' behaviors \([Notebook](/notebooks/chapter_05/chapter-05.ipynb)\) \([Livebook](https://livebook.manning.com/book/grokking-deep-reinforcement-learning/chapter-5)\)
  6. Improving agents' behaviors \([Notebook](/notebooks/chapter_06/chapter-06.ipynb)\) \([Livebook](https://livebook.manning.com/book/grokking-deep-reinforcement-learning/chapter-6)\)
  7. Achieving goals more effectively and efficiently \([Notebook](/notebooks/chapter_07/chapter-07.ipynb)\) \([Livebook](https://livebook.manning.com/book/grokking-deep-reinforcement-learning/chapter-7)\)
  8. Introduction to value-based deep reinforcement learning \([Notebook](/notebooks/chapter_08/chapter-08.ipynb)\) \([Livebook](https://livebook.manning.com/book/grokking-deep-reinforcement-learning/chapter-8)\)
  9. More stable value-based methods \([Notebook](/notebooks/chapter_09/chapter-09.ipynb)\) \([Livebook](https://livebook.manning.com/book/grokking-deep-reinforcement-learning/chapter-9)\)
  10. Sample-efficient value-based methods \([Notebook](/notebooks/chapter_10/chapter-10.ipynb)\) \([Livebook](https://livebook.manning.com/book/grokking-deep-reinforcement-learning/chapter-10)\)
  11. Introduction to policy-based deep reinforcement learning
  12. Parallelizing policy-based methods
  13. Deterministic policy gradient methods
  14. Conservative policy optimization methods
  15. Towards artificial general intelligence

### Table of content with implementation details

#### 1. Introduction to deep reinforcement learning
- \([Livebook](https://livebook.manning.com/book/grokking-deep-reinforcement-learning/chapter-1)\)
- \(No Notebook\)
      
#### 2. Mathematical foundations of reinforcement learning
- \([Livebook](https://livebook.manning.com/book/grokking-deep-reinforcement-learning/chapter-2)\)
- \([Notebook](/notebooks/chapter_02/chapter-02.ipynb)\)
    - Implementations of several MDPs: 
        - Bandit Walk
        - Bandit Slippery Walk
        - Slippery Walk Three
        - Random Walk
        - Russell and Norvig's Gridworld from AIMA
        - FrozenLake
        - FrozenLake8x8
#### 3. Balancing immediate and long-term goals
- \([Livebook](https://livebook.manning.com/book/grokking-deep-reinforcement-learning/chapter-3)\)
- \([Notebook](/notebooks/chapter_03/chapter-03.ipynb)\) 
    - Implementations of methods for finding optimal policies:
        - Policy Evaluation
        - Policy Improvement
        - Policy Iteration
        - Value Iteration
#### 4. Balancing the gathering and utilization of information
- \([Livebook](https://livebook.manning.com/book/grokking-deep-reinforcement-learning/chapter-4)\)
- \([Notebook](/notebooks/chapter_04/chapter-04.ipynb)\)
    - Implementations of exploration strategies for bandit problems:
        - Random
        - Greedy
        - E-greedy
        - E-greedy with linearly decaying epsilon
        - E-greedy with exponentially decaying epsilon
        - Optimistic initialization
        - SoftMax
        - Upper Confidence Bound
        - Bayesian
#### 5. Evaluating agents' behaviors
      - Implementation of algorithms that solve the prediction problem (policy estimation):
          - On-policy first-visit Monte-Carlo prediction
          - On-policy every-visit Monte-Carlo prediction
          - Temporal-Difference prediction (TD)
          - n-step Temporal-Difference prediction (n-step TD)
          - TD(λ)
####  6. [Improving agents' behaviors](/notebooks/chapter_06/chapter-06.ipynb)
      - Implementation of algorithms that solve the control problem (policy improvement):
          - On-policy first-visit Monte-Carlo control
          - On-policy every-visit Monte-Carlo control
          - On-policy TD control: SARSA
          - Off-policy TD control: Q-Learning
          - Double Q-Learning
  7. [Achieving goals more effectively and efficiently](/notebooks/chapter_07/chapter-07.ipynb)
      - Implementation of more effective and efficient reinforcement learning algorithms:
          - SARSA(λ) with replacing traces
          - SARSA(λ) with accumulating traces
          - Q(λ) with replacing traces
          - Q(λ) with accumulating traces
          - Dyna-Q
          - Trajectory Sampling
  8. [Introduction to value-based deep reinforcement learning](/notebooks/chapter_08/chapter-08.ipynb)
      - Implementation of a value-based deep reinforcement learning baseline:
          - Neural Fitted Q-iteration (NFQ)
  9. [More stable value-based methods](/notebooks/chapter_09/chapter-09.ipynb)
      - Implementation of "classic" value-based deep reinforcement learning methods:
          - Deep Q-Networks (DQN)
          - Double Deep Q-Networks (DDQN)
  10. [Sample-efficient value-based methods](/notebooks/chapter_10/chapter-10.ipynb)
      - Implementation of main improvements for value-based deep reinforcement learning methods:
          - Dueling Deep Q-Networks (Dueling DQN)
          - Prioritized Experience Replay (PER)
  11. Introduction to policy-based deep reinforcement learning
      - Implementation of classic policy-based deep reinforcement learning methods:
          - Policy Gradients without value function and Monte-Carlo returns (REINFORCE)
          - Policy Gradients with value function baseline trained with Monte-Carlo returns (VPG)  
  12. Parallelizing policy-based methods
      - Implementation of main improvements to policy-based deep reinforcement learning methods:
          - Asynchronous Advantage Actor-Critic (A3C)
          - Generalized Advantage Estimation (GAE)
          - \[Synchronous\] Advantage Actor-Critic (A2C)
  13. Deterministic policy gradient methods
      - Implementation of deterministic policy gradient deep reinforcement learning methods:
          - Deep Deterministic Policy Gradient (DDPG)
          - Twin Delayed Deep Deterministic Policy Gradient (TD3)
  14. Conservative policy optimization methods
      - Implementation of conservative policy gradient deep reinforcement learning methods:
          - Trust Region Policy Optimization (TRPO)
          - Proximal Policy Optimization (PPO)
  15. Towards artificial general intelligence
