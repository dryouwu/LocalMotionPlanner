function hT = createVehicleGraphic(ax,p,hTag)
    % Display collision checker
        hold on;
        ax.Visible = "off";
        x = ax.XLim;
        y = ax.YLim;
        xtext = ax.XLabel.String;
        ytext = ax.YLabel.String;
        checker = inflationCollisionChecker;
        checker.NumCircles = 3;
        checker.plot('Parent',ax,'Ruler','off');
        % Steal handles and reparent to hgTransform
%         pg = polyshape([2.4500 2.4500 3.4500 3.4500],[-0.8 0.8 0.7 -.7]);
        pg = polyshape([2.4500 2.4500 4.00 4.00],[-1.6 1.6 1.4 -1.4]);
        pg = plot(pg);
        pg.FaceColor = [1 216/255 0];
        pg.FaceAlpha = .9;
        ccHandles = ax.Children(1:10);
        hT = hgtransform(Parent=ax);
        hT.Tag = hTag;
        arrayfun(@(x)set(x,"Parent",hT),ccHandles);
        arrayfun(@(x)set(x,"Tag",hTag),ccHandles);
        hT.Matrix(1,end) = 5;         
        if isequal(hTag,'GoalVehicle')
            hT.Children(1).FaceColor = [1 0 0];
        else
            hT.Children(1).FaceColor = [1 216/255 0];
            hT.Children(1).FaceAlpha = .9;
        end
        for i=1:7
            child=hT.Children(i);
            child.Shape.Vertices(:,1) = child.Shape.Vertices(:,1) - (4.7/2);
            child.Shape.Vertices(:,2) = child.Shape.Vertices(:,2)*2;
        end
        ax.XLim = x;
        ax.YLim = y;
        ax.XLabel.String = xtext;
        ax.YLabel.String = ytext;
        ax.Visible = "on";
        delete(hT.Children([8 9]))
        R = eul2rotm([p(3) 0 0],'ZYX');
        hT.Matrix(1:3,:) = [R [p(1:2)'; 0]];
end 
% plot(mapCase2.CostMap);
% p1=[obstacle2 .2];
% hT = createVehicleGraphic(gca,"");
% R = eul2rotm([p1(3) 0 0],'ZYX');
% hT.Matrix(1:3,:) = [R [p1(1:2)'; 0]];

% Children
% 1 = body
% body,rear axle, f axle, rr,rl,fr,fl