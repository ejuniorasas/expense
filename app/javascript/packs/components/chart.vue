<script>
import { PolarArea } from 'vue-chartjs'
export default {
    props: {
        chartData: Object,
        label: String,
    },
    data: function() {
        return { 
            data:{
                labels: this.chartData.labels,
                datasets: [
                    { 
                        data: this.chartData.values,
                        backgroundColor: this.chartData.values.map(item =>'#'+(0x1000000+(Math.random())*0xffffff).toString(16).substr(1,6)),
                        label: this.label,
                    },
                ],
            },
            options: {
				responsive: true,
				legend: {
                    display: false,
					position: 'botton',
				},
				title: {
					display: false,
					// text: this.label,
				},
				scale: {
					ticks: {
						beginAtZero: false
					},
					reverse: false
				},
				animation: {
					animateRotate: false,
					animateScale: true
				}
			},
        };
    },
    extends: PolarArea,
    mounted () {
    this.renderChart(this.data, this.options);
  }
}

</script>