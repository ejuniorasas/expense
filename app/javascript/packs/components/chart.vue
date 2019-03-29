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
                labels: this.chartData,
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
					position: 'right',
				},
				title: {
					display: true,
					text: this.label,
				},
				scale: {
					ticks: {
						beginAtZero: true
					},
					reverse: false
				},
				animation: {
					animateRotate: true,
					animateScale: true
				}
			},
        };
    },
    extends: PolarArea,
    mounted () {
    this.renderChart(this.data.data, this.data.options);
  }
}

</script>