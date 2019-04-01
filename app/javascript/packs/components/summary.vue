<template>
    
  <div class="row">
    <div class="card-deck mb-3 text-center">
      <div class="card mb-4 shadow-sm" v-if="current_sumarize.show">
        <div class="card-header">
          <h4 class="my-0 font-weight-normal">Last Month</h4>
        </div>
        <div class="card-body">
          <h1 class="card-title pricing-card-title"><small class="text-muted">${{last_sumarize.total}}</small></h1>
          <polarchart cssClasses="mt-3 mb-4" label='Last month' :width='200' :height="200" :chartData="last_sumarize.category"></polarchart>
          
          <button type="button" class="btn btn-lg btn-block btn-outline-primary">Sign up for free</button>
        </div>
      </div>
      <div class="card mb-4 shadow-sm" v-if="current_sumarize.show">
        <div class="card-header">
          <h4 class="my-0 font-weight-normal">Current</h4>
        </div>
        <div class="card-body">
          <h1 class="card-title pricing-card-title">${{current_sumarize.total}} </h1>
          
          <polarchart cssClasses="mt-3 mb-4" label='Last month' :width='200' :height="200" :chartData="current_sumarize.category"></polarchart>

          <button type="button" class="btn btn-lg btn-block btn-primary">Get started</button>
        </div>
      </div>
      <div class="card mb-4 shadow-sm" v-if="next_sumarize.show">
        <div class="card-header">
          <h4 class="my-0 font-weight-normal">Next Month</h4>
        </div>
        <div class="card-body">
          <h1 class="card-title pricing-card-title"><small class="text-muted">${{next_sumarize.total}}</small></h1>
          
          <polarchart cssClasses="mt-3 mb-4" label='Last month' :width='200' :height="200" :chartData="next_sumarize.category"></polarchart>

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
      return { last_sumarize: this.calculeTotal(this.expenses.last),
        current_sumarize:  this.calculeTotal(this.expenses.current),
        next_sumarize: this.calculeTotal(this.expenses.next),
      };
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
              summarize.category.quantities[position] = summarize.category.quantities[position] + 1;
              summarize.category.values[position] = summarize.category.values[position] + item.value;
            }
          });
        });
        return summarize;
      }
    },
}
</script>