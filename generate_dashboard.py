import sqlite3
import pandas as pd
import json

# Connect to the database
conn = sqlite3.connect('carmax_v3.db')

# Query from the existing Unpivot_RFM_Cohort table
query = "SELECT * FROM Unpivot_RFM_Cohort ORDER BY idCustomer, Fecha;"

df = pd.read_sql_query(query, conn)
conn.close()

# Prepare data for chart: count by Fecha and Estado
chart_data = df.groupby(['Fecha', 'Estado']).size().unstack(fill_value=0)

# Get unique values for filters
r_labels = sorted(df['R_label'].unique())
f_labels = sorted(df['F_label'].unique())
m_labels = sorted(df['M_label'].unique())
scores_concat = sorted(df['Scores_Concat'].unique())

# Prepare datasets for Chart.js
labels = list(chart_data.index)
datasets = []
colors = ['rgba(255, 99, 132, 0.6)', 'rgba(54, 162, 235, 0.6)', 'rgba(255, 206, 86, 0.6)', 'rgba(75, 192, 192, 0.6)', 'rgba(153, 102, 255, 0.6)', 'rgba(255, 159, 64, 0.6)']
for i, estado in enumerate(chart_data.columns):
    datasets.append({
        'label': estado,
        'data': chart_data[estado].tolist(),
        'backgroundColor': colors[i % len(colors)],
        'borderColor': colors[i % len(colors)].replace('0.6', '1'),
        'borderWidth': 1
    })

# Generate HTML with Vue.js
html_template = f"""
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RFM Cohort Dashboard</title>
    <script src="https://cdn.jsdelivr.net/npm/vue@3"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {{ font-family: Arial, sans-serif; margin: 20px; }}
        .filters {{ margin-bottom: 20px; }}
        select {{ margin-right: 10px; padding: 5px; }}
        #chart {{ max-width: 800px; margin: auto; }}
    </style>
</head>
<body>
    <div id="app">
        <h1>RFM Cohort Analysis Dashboard</h1>

        <div class="filters">
            <label>R_label:
                <select v-model="filters.rLabel">
                    <option value="">All</option>
                    {"".join(f'<option value="{label}">{label}</option>' for label in r_labels)}
                </select>
            </label>

            <label>F_label:
                <select v-model="filters.fLabel">
                    <option value="">All</option>
                    {"".join(f'<option value="{label}">{label}</option>' for label in f_labels)}
                </select>
            </label>

            <label>M_label:
                <select v-model="filters.mLabel">
                    <option value="">All</option>
                    {"".join(f'<option value="{label}">{label}</option>' for label in m_labels)}
                </select>
            </label>

            <label>Scores_Concat:
                <select v-model="filters.scoresConcat">
                    <option value="">All</option>
                    {"".join(f'<option value="{score}">{score}</option>' for score in scores_concat)}
                </select>
            </label>
        </div>

        <canvas id="chart"></canvas>
    </div>

    <script>
        const {{ createApp }} = Vue;

        createApp({{
            data() {{
                return {{
                    data: {df.to_json(orient='records')},
                    filters: {{
                        rLabel: '',
                        fLabel: '',
                        mLabel: '',
                        scoresConcat: ''
                    }},
                    chart: null
                }};
            }},
            computed: {{
                filteredData() {{
                    return this.data.filter(item => {{
                        return (this.filters.rLabel === '' || item.R_label === this.filters.rLabel) &&
                               (this.filters.fLabel === '' || item.F_label === this.filters.fLabel) &&
                               (this.filters.mLabel === '' || item.M_label === this.filters.mLabel) &&
                               (this.filters.scoresConcat === '' || item.Scores_Concat === this.filters.scoresConcat);
                    }});
                }},
                chartData() {{
                    const grouped = {{}};
                    this.filteredData.forEach(item => {{
                        if (!grouped[item.Fecha]) grouped[item.Fecha] = {{}};
                        if (!grouped[item.Fecha][item.Estado]) grouped[item.Fecha][item.Estado] = 0;
                        grouped[item.Fecha][item.Estado]++;
                    }});
                    return grouped;
                }},
                labels() {{
                    return Object.keys(this.chartData).sort();
                }},
                datasets() {{
                    const estados = [...new Set(this.filteredData.map(item => item.Estado))];
                    const colors = ['rgba(255, 99, 132, 0.6)', 'rgba(54, 162, 235, 0.6)', 'rgba(255, 206, 86, 0.6)', 'rgba(75, 192, 192, 0.6)', 'rgba(153, 102, 255, 0.6)', 'rgba(255, 159, 64, 0.6)'];
                    return estados.map((estado, i) => ({{
                        label: estado,
                        data: this.labels.map(fecha => this.chartData[fecha][estado] || 0),
                        backgroundColor: colors[i % colors.length],
                        borderColor: colors[i % colors.length].replace('0.6', '1'),
                        borderWidth: 1
                    }}));
                }}
            }},
            mounted() {{
                this.updateChart();
            }},
            watch: {{
                datasets() {{
                    this.updateChart();
                }}
            }},
            methods: {{
                updateChart() {{
                    const ctx = document.getElementById('chart').getContext('2d');
                    if (this.chart) {{
                        this.chart.destroy();
                    }}
                    this.chart = new Chart(ctx, {{
                        type: 'bar',
                        data: {{
                            labels: this.labels,
                            datasets: this.datasets
                        }},
                        options: {{
                            scales: {{
                                x: {{
                                    stacked: true,
                                }},
                                y: {{
                                    stacked: true,
                                    beginAtZero: true
                                }}
                            }}
                        }}
                    }});
                }}
            }}
        }}).mount('#app');
    </script>
</body>
</html>
"""

with open('dashboard.html', 'w', encoding='utf-8') as f:
    f.write(html_template)

print("Dashboard generated: dashboard.html")