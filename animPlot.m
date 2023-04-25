function animPlot(chart,map,gifFileName)
    figure;
    plot(map.CostMap)
    hold on;
    exportgraphics(gca,gifFileName);
    plot(chart.trajectory(:,1),chart.trajectory(:,2),LineWidth=2,LineStyle='-.',Color='k')
    plot(chart.refPathOut(:,1),chart.refPathOut(:,2),LineWidth=2,LineStyle='-.',Color='g')
    scatter(chart.vehicle.startPose(1), chart.vehicle.startPose(2),8,'Marker','o','MarkerFaceColor','g','MarkerEdgeColor','g')
    scatter(chart.vehicle.goalPose(1),chart.vehicle.goalPose(2),8,'Marker','o','MarkerFaceColor','r','MarkerEdgeColor','r')
    legend('Danger Zone','Original path','Mitigated Path','Start Pose','Goal Pose')
    title(chart.endStateReached)
    hT = createVehicleGraphic(gca,chart.vehicle.startPose,"StartVehicle");
    pause(.1)
    for i=1:size(chart.refPathOut,1)
        exportgraphics(gca,gifFileName,Append=true);
        pose=chart.refPathOut(i,:);
        hT.Matrix(1:3,:)=[eul2rotm([pose(3) 0 0],'ZYX') [pose(1:2)'; 0]];
%         pause(.1)
    end
end