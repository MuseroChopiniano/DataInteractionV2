plotyApp = {
    sankey: function (divName,labels,source,target,values,title) {
        var data = {
            type: "sankey",
            arrangement: "freeform",
            orientation: "h",
            node: {
                pad: 50,
                thickness: 30,
                line: {
                    color: "black",
                    width: 0
                },
                label: labels,
                color: ["#fe6384", "#36a2eb", "#FECD58", "#fe6384", "#36a2eb", "#FECD58"]
            },

            link: {
                source: source,
                target: target,
                value: values,

            }
        }

        var data = [data]

        var layout = {
            title: title,
            font: {
                size: 10
            }
        }
        var config = { responsive: true };
        Plotly.react(divName, data, layout,config)
    }
};