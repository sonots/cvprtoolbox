% cvLibsvmDemo - Demo of cvLibsvm.m
function cvLibsvmDemo
%Example from Pattern Classification by Duda, et al. (DHS)
X(:, 1) = [1 5]'; C(1) = 1;
X(:, 2) = [2 3]'; C(2) = -1;
X(:, 3) = [-2 -4]'; C(3) = 1;
X(:, 4) = [-1 5]'; C(4) = -1;

% XOR example
% X(:, 1) = [1 1]'; C(1) = 1;
% X(:, 2) = [-1 1]'; C(2) = -1;
% X(:, 3) = [-1 -1]'; C(3) = 1;
% X(:, 4) = [1 -1]'; C(4) = -1;

cvLibsvmTrain(X, C, '-s 1 -t 2 -c 1 -g 0.5');
Classified = cvLibsvmPredict(X);
fprintf('<- Do not see the above LIBSVM''s accuracy. Get in matlab.\n');
fprintf('Accuracy = %f\n', sum(C == Classified) / size(C, 2));
% Usage: svm-train [options] training_set_file [model_file]
% options:
% -s svm_type : set type of SVM (default 0)
% 	0 -- C-SVC
% 	1 -- nu-SVC
% 	2 -- one-class SVM
% 	3 -- epsilon-SVR
% 	4 -- nu-SVR
% -t kernel_type : set type of kernel function (default 2)
% 	0 -- linear: u'*v
% 	1 -- polynomial: (gamma*u'*v + coef0)^degree
% 	2 -- radial basis function: exp(-gamma*|u-v|^2)
% 	3 -- sigmoid: tanh(gamma*u'*v + coef0)
% 	4 -- precomputed kernel (kernel values in training_set_file)
% -d degree : set degree in kernel function (default 3)
% -g gamma : set gamma in kernel function (default 1/k)
% -r coef0 : set coef0 in kernel function (default 0)
% -c cost : set the parameter C of C-SVC, epsilon-SVR, and nu-SVR (default 1)
% -n nu : set the parameter nu of nu-SVC, one-class SVM, and nu-SVR (default 0.5)
% -p epsilon : set the epsilon in loss function of epsilon-SVR (default 0.1)
% -m cachesize : set cache memory size in MB (default 100)
% -e epsilon : set tolerance of termination criterion (default 0.001)
% -h shrinking: whether to use the shrinking heuristics, 0 or 1 (default 1)
% -b probability_estimates: whether to train an SVC or SVR model for probability estimates, 0 or 1 (default 0)
% -wi weight: set the parameter C of class i to weight*C in C-SVC (default 1)
% -v n: n-fold cross validation mode
% The k in the -g option means the number of attributes in the input data.
% option -v randomly splits the data into n parts and calculates cross
% validation accuracy/mean squared error on them.
