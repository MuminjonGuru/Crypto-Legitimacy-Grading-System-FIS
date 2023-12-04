warning('off', 'fuzzy:general:warnDeprecation_Newfis')
warning('off', 'fuzzy:general:warnDeprecation_Addvar')
warning('off', 'fuzzy:general:warnDeprecation_Addmf')
warning('off', 'fuzzy:general:warnDeprecation_Evalfis')
clc; clear;

% a new Fuzzy Inference System 
fis = newfis('CryptoLegitimacyGrading','mamdani');

% Market Capitalization Input
fis = addvar(fis, 'input', 'Market Capitalization', [0 100]);  
% membership functions for Market Capitalization
fis = addmf(fis, 'input', 1, 'Low', 'trapmf', [0 0 20 40]);  % lower market cap
fis = addmf(fis, 'input', 1, 'Medium', 'trapmf', [30 50 70 90]);  % medium market cap
fis = addmf(fis, 'input', 1, 'High', 'trapmf', [80 100 100 100]);  % higher market cap


% Add Transaction Data Input
fis = addvar(fis, 'input', 'Transaction Data', [0 100]); % Range up to 100
% membership functions for daily transactions
fis = addmf(fis, 'input', 2, 'Low', 'trapmf', [0 0 10 30]); 
fis = addmf(fis, 'input', 2, 'Medium', 'trapmf', [20 40 60 80]); 
fis = addmf(fis, 'input', 2, 'High', 'trapmf', [70 85 100 100]); 


% Developer Activity Input
fis = addvar(fis, 'input', 'Developer Activity', [0 100]);
% Defining membership functions for Developer Activity
fis = addmf(fis, 'input', 3, 'Low', 'trapmf', [0 0 20 40]);  
fis = addmf(fis, 'input', 3, 'Medium', 'trapmf', [30 50 70 90]);
fis = addmf(fis, 'input', 3, 'High', 'trapmf', [80 100 100 100]);


% Environmental Impact Input
fis = addvar(fis, 'input', 'Environmental Impact', [0 100]);
% membership functions for Environmental Impact
fis = addmf(fis, 'input', 4, 'Low', 'trapmf', [0 0 20 40]);  
fis = addmf(fis, 'input', 4, 'Medium', 'trapmf', [30 50 70 90]);
fis = addmf(fis, 'input', 4, 'High', 'trapmf', [80 100 100 100]);


% Complexity vs. Utility Input
fis = addvar(fis, 'input', 'Complexity vs. Utility', [0 100]);
% membership functions for Complexity vs. Utility
fis = addmf(fis, 'input', 5, 'Low', 'trapmf', [0 0 20 40]);  
fis = addmf(fis, 'input', 5, 'Medium', 'trapmf', [30 50 70 90]);
fis = addmf(fis, 'input', 5, 'High', 'trapmf', [80 100 100 100]);


% The output variable for Legitimacy Grading
fis = addvar(fis, 'output', 'Legitimacy Grade', [0 100]);
% membership functions for Legitimacy Grading
fis = addmf(fis, 'output', 1, 'Not Legit', 'trapmf', [0 0 15 30]);
fis = addmf(fis, 'output', 1, 'Somewhat Legit', 'trimf', [20 40 60]);
fis = addmf(fis, 'output', 1, 'Moderately Legit', 'trimf', [50 70 90]);
fis = addmf(fis, 'output', 1, 'Highly Legit', 'trapmf', [80 95 100 100]);


rules = [
    % High market cap generally indicates legitimacy
    3 0 0 0 0 4 1 1;  % High Market Cap => Highly Legit
    3 0 2 0 0 4 1 1;  % High Market Cap & Low Developer Activity => Highly Legit
    3 3 0 0 0 4 1 1;  % High Market Cap & High Developer Activity => Highly Legit
    3 0 0 3 0 4 1 1;  % High Market Cap & High Environmental Impact => Highly Legit
    3 0 0 0 3 4 1 1;  % High Market Cap & High Utility => Highly Legit

    % High Market Cap with varied other factors
    3 2 0 0 0 4 1 1; % High Market Cap & Medium Developer Activity => Highly Legit
    3 0 0 2 0 4 1 1; % High Market Cap & Medium Environmental Impact => Highly Legit
    3 0 0 0 2 4 1 1; % High Market Cap & Medium Utility => Highly Legit
    3 1 0 0 0 3 1 1; % High Market Cap & Low Transaction => Moderately Legit
    
    % Medium market cap indicates moderate legitimacy
    2 0 0 0 0 3 1 1;  % Medium Market Cap => Moderately Legit
    2 2 0 0 0 3 1 1;  % Medium Market Cap & Medium Developer Activity => Moderately Legit
    2 0 0 2 0 3 1 1;  % Medium Market Cap & Medium Environmental Impact => Moderately Legit
    2 0 0 0 2 3 1 1;  % Medium Market Cap & Medium Utility => Moderately Legit

    % Low market cap may indicate lower legitimacy
    1 0 0 0 0 2 1 1;  % Low Market Cap => Somewhat Legit
    1 1 0 0 0 1 1 1;  % Low Market Cap & Low Developer Activity => Not Legit
    1 0 0 1 0 2 1 1;  % Low Market Cap & Low Environmental Impact => Somewhat Legit
    1 0 0 0 1 2 1 1;  % Low Market Cap & Low Utility => Somewhat Legit

    % Consider combinations of other factors
    0 3 3 0 0 4 1 1;  % High Transaction & High Developer Activity => Highly Legit
    0 1 1 0 0 1 1 1;  % Low Transaction & Low Developer Activity => Not Legit
    0 0 3 3 0 4 1 1;  % High Developer Activity & High Environmental Impact => Highly Legit
    0 0 1 1 0 2 1 1;  % Low Developer Activity & Low Environmental Impact => Somewhat Legit
    0 0 0 3 3 4 1 1;  % High Environmental Impact & High Utility => Highly Legit
    0 0 0 1 1 2 1 1;  % Low Environmental Impact & Low Utility => Somewhat Legit
    0 3 0 0 3 4 1 1;  % High Transaction & High Utility => Highly Legit
    0 1 0 0 1 1 1 1;  % Low Transaction & Low Utility => Not Legit

    % Low Market Cap with varied other factors
    1 3 0 0 0 2 1 1; % Low Market Cap & High Developer Activity => Somewhat Legit
    1 0 3 0 0 1 1 1; % Low Market Cap & High Transaction => Not Legit
    1 0 0 1 3 2 1 1; % Low Market Cap & Low Environmental Impact & High Utility => Somewhat Legit
    1 2 0 0 0 1 1 1; % Low Market Cap & Medium Developer Activity => Not Legit
    1 0 2 0 0 1 1 1; % Low Market Cap & Medium Transaction => Not Legit

    % Specific combinations indicating potential risks
    0 1 1 3 0 1 1 1; % Low Transaction & Low Developer Activity & High Environmental Impact => Not Legit
    0 2 2 0 1 2 1 1; % Medium Transaction & Medium Developer Activity & Low Utility => Somewhat Legit
    0 3 1 0 0 3 1 1; % High Transaction & Low Developer Activity => Moderately Legit
    0 0 2 2 0 2 1 1; % Medium Developer Activity & Medium Environmental Impact => Somewhat Legit
    0 0 0 2 2 3 1 1; % Medium Environmental Impact & Medium Utility => Moderately Legit
    0 0 1 0 3 2 1 1; % Low Developer Activity & High Utility => Somewhat Legit

    % High Transaction, Developer Activity, OR High Utility indicates legitimacy
    0 3 3 0 3 4 1 1; % High Transaction OR High Developer Activity OR High Utility => Highly Legit
    0 2 2 0 2 3 1 1; % Medium Transaction OR Medium Developer Activity OR Medium Utility => Moderately Legit
    
    % High Market Cap with High/Medium Developer Activity and Utility
    3 3 0 0 3 4 1 1; % High Market Cap AND High Developer Activity AND High Utility => Highly Legit
    3 2 0 0 2 4 1 1; % High Market Cap AND Medium Developer Activity AND Medium Utility => Highly Legit
    
    % Medium Market Cap with balanced factors
    2 2 2 0 2 3 1 1; % Medium Market Cap AND Medium Transaction AND Medium Developer Activity => Moderately Legit
    
    % Low Market Cap but high Developer Activity or Utility
    1 3 0 0 3 3 1 1; % Low Market Cap BUT High Developer Activity OR High Utility => Moderately Legit
    1 0 3 0 3 3 1 1; % Low Market Cap BUT High Transaction OR High Utility => Moderately Legit
    
    % Handling Stablecoins and Environmental Impact
    0 0 0 3 1 2 1 1; % Medium Environmental Impact AND Low Utility => Somewhat Legit
    0 0 0 1 3 1 1 1; % High Environmental Impact AND Low Utility => Not Legit

    % If Developer Activity is High, but Transaction Volume is Medium, still consider Highly Legit
    0 2 3 0 0 4 1 1; % Medium Transaction & High Developer Activity => Highly Legit
    
    % High Developer Activity with any level of Market Cap or Utility indicates high legitimacy
    0 0 3 0 3 4 1 1; % High Developer Activity & High Utility => Highly Legit
    1 0 3 0 0 4 1 1; % Low Market Cap & High Developer Activity => Highly Legit
    2 0 3 0 0 4 1 1; % Medium Market Cap & High Developer Activity => Highly Legit
    3 0 3 0 0 4 1 1; % High Market Cap & High Developer Activity => Highly Legit
    
    % Consider the balance between Environmental Impact and Utility for Ethereum
    0 0 0 2 3 4 1 1; % Medium Environmental Impact & High Utility (like smart contracts) => Highly Legit

        
];
fis = addRule(fis, rules);



% ======= Batch Processing on Gathered Crypto Coins ======== %

% import data from Excel
filename = 'Findings_v1.xlsx';
dataTable = readtable(filename, 'ReadVariableNames', false);

% Market Cap. values (Column A)
maxMarketCap = max(dataTable.Var1); % Var1 is now Market Cap Data column
normalizedMarketCap = 100 * (dataTable.Var1 / maxMarketCap); % 0-100

% Transaction Data is in billions and needs to be normalized to 0-100
maxTransaction = max(dataTable.Var2); % Var2 is Transaction Data column
normalizedTransaction = 100 * (dataTable.Var2 / maxTransaction); % 0-100

% preallocation for the array
numCoins = height(dataTable);
legitimacyGrades = zeros(numCoins, 1);

for i = 1:numCoins
    % Extract and scale input data for each coin
    marketCap = normalizedMarketCap(i);      % normalized market cap. 
    transaction = normalizedTransaction(i);  % normalized transaction data.
    developerActivity = dataTable.Var3(i);   % Column C - dev activity 
    environmentalImpact = dataTable.Var4(i); % Column D - env. impact
    utility = dataTable.Var5(i);             % Column E utility level

    % Prepare input array for FIS
    inputArray = [marketCap, transaction, developerActivity, environmentalImpact, utility];

    % Evaluate using FIS
    legitimacyGrades(i) = evalfis(fis, inputArray);
end

% Combine cryptocurrency names [column 6] and legitimacy grades [output]
outputTable = table(dataTable.Var6, legitimacyGrades, 'VariableNames', ...
                    {'CryptoName', 'LegitimacyGrade'});

% write to a new Excel file
outputFilename = 'LegitimacyGradesOutput.xlsx';
writetable(outputTable, outputFilename);

% =======        End for the Batch Processing       ======== %



% Visualization of the Fuzzy Inference System
figure;

% Plot for Circulation Data
subplot(6,1,1)
plotmf(fis, 'input', 1)

% Plot for Transaction Data
subplot(6,1,2)
plotmf(fis, 'input', 2)

% Plot for Developer Activity
subplot(6,1,3)
plotmf(fis, 'input', 3)

% Plot for Environmental Impact
subplot(6,1,4)
plotmf(fis, 'input', 4)

% Plot for Complexity vs. Utility
subplot(6,1,5)
plotmf(fis, 'input', 5)

% Plot for Legitimacy Grade
subplot(6,1,6)
plotmf(fis, 'output', 1)
