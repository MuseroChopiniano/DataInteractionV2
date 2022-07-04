chartApp = {

    colors: [
        '#fe6384',
        '#36a2eb',
        'rgb(255, 205, 86)'
    ],

    initInteractionsByChannelChart: function (chartElement, dataset, labels,title) {

        var colorIndex = 0;
        dataset.map(d => {
            if (colorIndex > this.colors.length - 1) {
                colorIndex = 0;
            }
            d['borderColor'] = this.colors[colorIndex];
            d['backgroundColor'] = this.colors[colorIndex];
            colorIndex++;
        });


        const data = {
            labels: labels,
            datasets: dataset
        };

        const chartConfig = {
            type: 'line',
            data: data,
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    title: {
                        display: true,
                        text: title
                    }
                }
            }
        };

        const myChart = new Chart(
            chartElement,
            chartConfig
        );
    },
    initRevByChannelChart: function (chartElement, dataset, labels, title) {

        const data = {
            labels: labels,
            datasets: [{
                label: 'My First Dataset',
                data: dataset,
                backgroundColor: this.colors,
                hoverOffset: 4
            }]
        };

        const chartConfig = {
            type: 'pie',
            data: data,
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    title: {
                        display: true,
                        text: title
                    }
                }
            },
        };
        const myChart = new Chart(
            chartElement,
            chartConfig
        );
    }
    

}