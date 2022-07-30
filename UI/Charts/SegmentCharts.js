segmentApp = {
    initSegmentChart: function (chartElement, data, xTitle, yTitle) {
        const config = {
            type: 'scatter',
            data: {
                datasets: data
            },
            options: {
                plugins: {
                   
                    tooltip: {
                        callbacks: {
                            label: (context) => {
                                return `${xTitle}: ${context.raw.x}, ${yTitle}: ${context.raw.y}, CustomerId:${context.raw.id}`;
                            }
                        }
                    }
                },
                scales: {
                    x: {
                        type: 'linear',
                        position: 'bottom',
                        title: {
                            text: xTitle,
                            display: true,
                        }
                    },
                    y: {
                        title: {
                            text: yTitle,
                            display: true,
                        }
                    }
                }
            }
        };
        const myChart = new Chart(
            chartElement, config);
    }
}