%% 2016-08-11
% calculate the pdfs of the particular class
function X_pdf_sel = pdf_class(featurepool,K)
    X_pdf_sel = [];
    D = pdist2(featurepool,featurepool,'euclidean');
    len_pool = length(D);
    % for assigning the membership values
    X_pdf = zeros(len_pool,1);
    d_counter = 1;
    distances = zeros(len_pool*K,1);
    for n = 1:len_pool
        d = D(n,:);
        dsort = sort(d);
        for k = 1:K
            distances(d_counter) = dsort(k+1);
            d_counter = d_counter+1;
        end
    end
    
    % calculate mean and standard deviation distance
%     max_D = max(distances);
%     min_D = min(distances);
%     xrange = min_D:((max_D-min_D)/length(distances)):max_D;
    mu_D  = mean(distances);
    st_D  = std(distances);
    % find the probability distribution using the mean and standard deviation
    dist_prob = normpdf(distances',mu_D,st_D);
    
    %dist_prob1 = pdf('Normal',xrange,mu_D,st_D);
    
    for n=1:len_pool
        d=D(n,:);
        d_sort=sort(d);
        selected(n,:)=d_sort(2:k+1);
        %d_k_min=selected(n,1);%d_sort(2);
        d_k_max(n,1)=selected(n,K);%d_sort(K+1);
        %d_k_avg=mean(selected(n,:));
        % index of selected distance
        indx=find(distances==d_k_max(n,1));
        X_pdf(n,1)=dist_prob(indx(1));
    end
    
    indx = find(X_pdf(:,1)==max(X_pdf(:,1)));
    % cross check if there are two peaks in probability.
    [noofindx,~] = size(indx);
    if noofindx>1
        check = sum(selected(indx,:)');
        selecindx = find(check==max(check));
    else
        selecindx = 1;
    end

    % find the distances that are below the selected pdf and use the formula
    for n = 1:len_pool
        if selected(n,K) < selected(indx(selecindx),1)
           X_pdf_sel(n) = X_pdf(indx(selecindx),1) + (X_pdf(indx(selecindx),1) - X_pdf(n,1));
        else
           X_pdf_sel(n) = X_pdf(n,1);
        end
    end
   X_pdf_sel = mat2gray(X_pdf_sel);
end