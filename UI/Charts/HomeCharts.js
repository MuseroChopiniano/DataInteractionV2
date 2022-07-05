chartApp = {

    colors: [
        '#fe6384',
        '#36a2eb',
        'rgb(255, 205, 86)'
    ],
    otherColors: [
        '#341c93'
    ],
    fontsize: 15,

    initInteractionsByChannelChart: function (chartElement, dataset, labels,title) {

        var colorIndex = 0;
        dataset.map(d => {
            if (colorIndex > this.colors.length - 1) {
                colorIndex = 0;
            }
            d['borderColor'] = this.colors[colorIndex];
            d['backgroundColor'] = this.colors[colorIndex];
            d['tension'] = 0.25;
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
                        text: title,
                        font: {
                            size:this.fontsize
                        }
                        
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
                        text: title,
                        font: {
                            size: this.fontsize
                        }
                    }
                }
            },
        };
        const myChart = new Chart(
            chartElement,
            chartConfig
        );
    },

    initCampaignStatusChart: function (chartElement, dataset, labels, title) {

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
            type: 'doughnut',
            data: data,
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    title: {
                        display: true,
                        text: title,
                        font: {
                            size: this.fontsize
                        }
                    }
                }
            },
        };
        const myChart = new Chart(
            chartElement,
            chartConfig
        );
    },


    initIntByTypeChart: function (chartElement, dataset, labels, title) {

        const data = {
            labels: labels,
            datasets: [{
                label: 'My First Dataset',
                data: dataset,
                backgroundColor: this.colors,
                borderColor: this.colors,
                hoverOffset: 4
            }]
        };

        const chartConfig = {
            type: 'bar',
            data: data,
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                },
                responsive: true,
                plugins: {
                    legend: {
                        display: false,

                    },
                    title: {
                        display: true,
                        text: title,
                        font: {
                            size: this.fontsize
                        }
                    }
                }
            },
        };
        const myChart = new Chart(
            chartElement,
            chartConfig
        );
    },
    initCampaignBudgetVariance: function (chartElement, actualDataset, budgetedDataset, labels, title) {

        const data = {
            labels: labels,
            datasets: [{
                label: 'Actual Spend',
                data: actualDataset,
                backgroundColor: this.colors,
                borderColor: this.colors,
                hoverOffset: 4
            }, {
                label: 'Budgeted Amount',
                data: budgetedDataset,
                backgroundColor: this.otherColors,
                borderColor: this.otherColors,
                hoverOffset: 4
            }
            ]
        };

        const chartConfig = {
            type: 'bar',
            data: data,
            options: {
                scales: {
                    xAxes: [{
                        stacked: true,
                    }],
                    yAxes: [{
                        ticks: {
                            beginAtZero: true
                        }
                    }]
                },
                responsive: true,
                plugins: {
                    legend: {
                        display: true,

                    },
                    title: {
                        display: true,
                        text: title,
                        font: {
                            size: this.fontsize
                        }
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