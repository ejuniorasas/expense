<template>
    
  <div class="row">
    <div class="card-deck mb-3 text-center">
      <div class="card mb-4 shadow-sm" v-if="last.show">
        <div class="card-header">
          <h4 class="my-0 font-weight-normal">Last Month</h4>
        </div>
        <div class="card-body">
          <h1 class="card-title pricing-card-title"><small class="text-muted">${{last.total}}</small></h1>
          <polarchart cssClasses="mt-3 mb-4" :chartData="last.category"></polarchart>
          
          <button type="button" class="btn btn-lg btn-block btn-outline-primary">Sign up for free</button>
        </div>
      </div>
      <div class="card mb-4 shadow-sm" v-if="current.show">
        <div class="card-header">
          <h4 class="my-0 font-weight-normal">Current</h4>
        </div>
        <div class="card-body">
          <h1 class="card-title pricing-card-title">${{current.total}} </h1>
          <ul class="list-unstyled mt-3 mb-4">
            <li>20 users included</li>
            <li>10 GB of storage</li>
            <li>Priority email support</li>
            <li>Help center access</li>
          </ul>
          <button type="button" class="btn btn-lg btn-block btn-primary">Get started</button>
        </div>
      </div>
      <div class="card mb-4 shadow-sm" v-if="next.show">
        <div class="card-header">
          <h4 class="my-0 font-weight-normal">Next Month</h4>
        </div>
        <div class="card-body">
          <h1 class="card-title pricing-card-title"><small class="text-muted">${{next.total}}</small></h1>
          <ul class="list-unstyled mt-3 mb-4">
            <li>30 users included</li>
            <li>15 GB of storage</li>
            <li>Phone and email support</li>
            <li>Help center access</li>
          </ul>
          <button type="button" class="btn btn-lg btn-block btn-primary">Contact us</button>
        </div>
      </div>
    </div>
  </div>

</template>

<script>
import Polarchart from './chart.vue'
export default {
    props: {
        expenses: Object,
    },

    components: {
      polarchart: Polarchart,
    },

    data: function () {
      let summarize = {last: {}, current: {}, next: {}};
      summarize.last = this.calculeTotal(this.expenses.last);
      summarize.current = this.calculeTotal(this.expenses.current);
      summarize.next = this.calculeTotal(this.expenses.next);
      return summarize;
    },

    methods: {
      calculeTotal(items) {
        let summarize = {quantity: items.length, total: 0.0, show: false, category: {labels: [], quantities:[], values:[]}};
        items.map(item =>{
          let tags = item.tags && item.tags.length >0 ? item.tags : ['no tag'];
          summarize.total += item.value;

          if(!summarize.show) {
            summarize.show = true;
          }

          tags.map(tag =>{
            let position = summarize.category.labels.indexOf(tag);
            if(position === -1) {
              summarize.category.quantities.push(1);
              summarize.category.labels.push(tag);
              summarize.category.values.push(0.00 + item.value);
            } else {
              summarize.category.quantity[position] = summarize.category.quantity[position] + 1;
              summarize.category.value[position] = summarize.category.value[position] + item.value;
            }
          });

        });
        return summarize;
      }
    },
    computed: {

    },
}
</script>