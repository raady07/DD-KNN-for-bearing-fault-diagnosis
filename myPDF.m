function X_req = myPDF(trainsamples, trainclass, testsamples, K, no_classes)
% Version 3: 2016-Sep-05
% trainsamples
    [row,~] = size(trainsamples);

    j1 = 1;j2 =1; j3 = 1; j4 =1;
    j5 = 1;j6 =1; j7 = 1; j8 =1;
    for i = 1:row 
        if(trainclass(i) == 1)
            pool1(j1,:) = trainsamples(i,:);
            j1 = j1+1;
        end
        if(trainclass(i) == 2)
            pool2(j2,:) = trainsamples(i,:);
            j2 = j2+1;
        end
        if(trainclass(i) == 3)
            pool3(j3,:) = trainsamples(i,:);
            j3 = j3+1;
        end
        if(trainclass(i) == 4)
            pool4(j4,:) = trainsamples(i,:);
            j4 = j4+1;
        end
        if (no_classes == 8)
            if(trainclass(i) == 5)
                pool5(j5,:) = trainsamples(i,:);
                j5 = j5+1;
            end
            if(trainclass(i) == 6)
                pool6(j6,:) = trainsamples(i,:);
                j6 = j6+1;
            end
            if(trainclass(i) == 7)
                pool7(j7,:) = trainsamples(i,:);
                j7 = j7+1;
            end
            if(trainclass(i) == 8)
                pool8(j8,:) = trainsamples(i,:);
                j8 = j8+1;
            end
        end
    end

    [row,~] = size(testsamples);

    for i = 1:row
        pdfsamples = [pool1;testsamples(i,:)];
        X = pdf_class(pdfsamples,K);
        X_req(i,1) = X(length(X));
        pdfsamples = [pool2;testsamples(i,:)];
        X = pdf_class(pdfsamples,K);
        X_req(i,2) = X(length(X));
        pdfsamples = [pool3;testsamples(i,:)];
        X = pdf_class(pdfsamples,K);
        X_req(i,3) = X(length(X));
        pdfsamples = [pool4;testsamples(i,:)];
        X = pdf_class(pdfsamples,K);
        X_req(i,4) = X(length(X));
        if (no_classes == 8)
            pdfsamples = [pool5;testsamples(i,:)];
            X = pdf_class(pdfsamples,K);
            X_req(i,5) = X(length(X));
            pdfsamples = [pool6;testsamples(i,:)];
            X = pdf_class(pdfsamples,K);
            X_req(i,6) = X(length(X));
            pdfsamples = [pool7;testsamples(i,:)];
            X = pdf_class(pdfsamples,K);
            X_req(i,7) = X(length(X));
            pdfsamples = [pool8;testsamples(i,:)];
            X = pdf_class(pdfsamples,K);
            X_req(i,8) = X(length(X));
        end
    end
end