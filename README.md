# Crypto-Legitimacy-Grading-System-FIS-
Cryptocurrency Legitimacy Grading System that uses FIS (Fuzzy Inference System) [Matlab]

The current rules are based on the 5 input data I have. All the combinations for the 5 inputs are not fully covered but has some essential ones like:
- Medium Market Cap & Medium Utility => Moderately Legit
- Low Market Cap & Low Developer Activity => Not Legit
- Low Market Cap & Low Utility => Somewhat Legit
- High Transaction & High Utility => Highly Legit

These are based on some of the ideas I've got from 
- https://koinly.io/blog/crypto-rug-pulls-guide/

Here is the current state of the grading system which does not include everything but somehow gives moderately legit grading :)

After the last update on the rules, this is the new output

![enter image description here](https://github.com/MuminjonGuru/Crypto-Legitimacy-Grading-System-FIS/blob/main/grading_final.png)

As you can see we have low grading for the ETH and that already shows the issue in the fuzzy inference system. 
My potential plan is to check rule effectiveness, analysis required for various input factors and overall model calibration.

White Paper on the Fuzzy Inference System: 
![DOWNLOAD PDF](https://github.com/MuminjonGuru/Crypto-Legitimacy-Grading-System-FIS/blob/main/FuzzyLogic_Muminjon_P2822156.pdf)

