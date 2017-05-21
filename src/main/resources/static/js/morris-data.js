// Morris.js Charts sample data for SB Admin template

$(function() {

    // dashboard
    Morris.Area({
        element: 'morris-area-chart',
        data: [
            {y: 'SNMPTN', a: 3000, b: 0, c:0, d:0},
            {y: 'PPKB', a: 575, b: 0, c:0, d:400},
            {y: 'Talent Scouting', a: 400, b: 0, c:0, d:0},
            {y: 'SBMPTN', a: 2000, b: 0, c:0, d:0},
            {y: 'SIMAK UI', a: 1000, b: 700, c:400, d: 1000},
            {y: 'Jalur Olimpiade', a: 300, b: 0, c:0, d:0}
          ],
          parseTime: false,
          xkey: 'y',
          ykeys: ['a', 'b', 'c', 'd'],
          labels: ['S1', 'S2', 'S3', 'D3'],
        pointSize: 2,
        hideHover: 'auto',
        resize: true
    });

    // dashboard
    Morris.Donut({
        element: 'morris-donut-chart',
        data: [{
            label: "FASILKOM",
            value: 500
        }, {
            label: "FISIP",
            value: 1500
        }, {
            label: "FT",
            value: 1700
        }, {
            label: "FIB",
            value: 1600
        }, {
            label: "FPsi",
            value: 600
        }, {
            label: "FH",
            value: 700
        }, {
            label: "FMIPA",
            value: 1000
        }, {
            label: "FEB",
            value: 1100
        }, {
            label: "FK",
            value: 500
        }, {
            label: "FKG",
            value: 400
        }, {
            label: "FIK",
            value: 350
        }, {
            label: "FKM",
            value: 400
        }],
        resize: true
    });
    
 // s3
    
    
    
    //s2
    
    
    //s1
    
    
  //reg
    
    
  //par
    
    
 // inter
    
    
    //vokasi tiap rumpun
    

//    // Line Chart
//    Morris.Line({
//        // ID of the element in which to draw the chart.
//        element: 'morris-line-chart',
//        // Chart data records -- each entry in this array corresponds to a point on
//        // the chart.
//        data: [{
//            d: '2012-10-01',
//            visits: 802
//        }, {
//            d: '2012-10-02',
//            visits: 783
//        }, {
//            d: '2012-10-03',
//            visits: 820
//        }, {
//            d: '2012-10-04',
//            visits: 839
//        }, {
//            d: '2012-10-05',
//            visits: 792
//        }, {
//            d: '2012-10-06',
//            visits: 859
//        }, {
//            d: '2012-10-07',
//            visits: 790
//        }, {
//            d: '2012-10-08',
//            visits: 1680
//        }, {
//            d: '2012-10-09',
//            visits: 1592
//        }, {
//            d: '2012-10-10',
//            visits: 1420
//        }, {
//            d: '2012-10-11',
//            visits: 882
//        }, {
//            d: '2012-10-12',
//            visits: 889
//        }, {
//            d: '2012-10-13',
//            visits: 819
//        }, {
//            d: '2012-10-14',
//            visits: 849
//        }, {
//            d: '2012-10-15',
//            visits: 870
//        }, {
//            d: '2012-10-16',
//            visits: 1063
//        }, {
//            d: '2012-10-17',
//            visits: 1192
//        }, {
//            d: '2012-10-18',
//            visits: 1224
//        }, {
//            d: '2012-10-19',
//            visits: 1329
//        }, {
//            d: '2012-10-20',
//            visits: 1329
//        }, {
//            d: '2012-10-21',
//            visits: 1239
//        }, {
//            d: '2012-10-22',
//            visits: 1190
//        }, {
//            d: '2012-10-23',
//            visits: 1312
//        }, {
//            d: '2012-10-24',
//            visits: 1293
//        }, {
//            d: '2012-10-25',
//            visits: 1283
//        }, {
//            d: '2012-10-26',
//            visits: 1248
//        }, {
//            d: '2012-10-27',
//            visits: 1323
//        }, {
//            d: '2012-10-28',
//            visits: 1390
//        }, {
//            d: '2012-10-29',
//            visits: 1420
//        }, {
//            d: '2012-10-30',
//            visits: 1529
//        }, {
//            d: '2012-10-31',
//            visits: 1892
//        }, ],
//        // The name of the data record attribute that contains x-visitss.
//        xkey: 'd',
//        // A list of names of data record attributes that contain y-visitss.
//        ykeys: ['visits'],
//        // Labels for the ykeys -- will be displayed when you hover over the
//        // chart.
//        labels: ['Visits'],
//        // Disables line smoothing
//        smooth: false,
//        resize: true
//    });

    // Bar Chart
//    Morris.Bar({
//        element: 'morris-bar-chart',
//        data: [{
//            device: 'iPhone',
//            geekbench: 136
//        }, {
//            device: 'iPhone 3G',
//            geekbench: 137
//        }, {
//            device: 'iPhone 3GS',
//            geekbench: 275
//        }, {
//            device: 'iPhone 4',
//            geekbench: 380
//        }, {
//            device: 'iPhone 4S',
//            geekbench: 655
//        }, {
//            device: 'iPhone 5',
//            geekbench: 1571
//        }],
//        xkey: 'device',
//        ykeys: ['geekbench'],
//        labels: ['Geekbench'],
//        barRatio: 0.4,
//        xLabelAngle: 35,
//        hideHover: 'auto',
//        resize: true
//    });
});
