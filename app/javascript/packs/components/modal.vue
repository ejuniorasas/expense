// http://www.vue-tags-input.com/#/examples/autocomplete

<template>
    <transition name="modal">
        <div class="modal-mask" @click="close" v-show="show">
            <div class="modal-container" @click.stop>
                <div class="modal-header">
                    <slot name="header">
                        <h3>Add Expense</h3>
                    </slot>
                <pre> {{expense}} </pre>
                </div>
                <div class="modal-body">

                    <div class="form-group">
                        <label for="name">Expense</label>
                        <input type="text" class="form-control" id="name" aria-describedby="nameHelp" v-model="expense.name" placeholder="Enter an expense name">
                        <small id="nameHelp" class="form-text text-muted">A name that could be easy to identify the expense.</small>
                    </div>
                    <div class="form-row">
                        <div class="col-md-1"> 
                            <label for="value" >Value: </label>
                        </div>
                        <div class="col-md-2">
                            <input type="number" class="form-control" name="value" id="value" required step=".01" v-model="expense.value">
                        </div>
                        <div class="col-md-1">
                            <label for="status">Status: </label>
                        </div>
                        <div class="col-md-3">
                            <select name="status" id="status" v-model="expense.status" class="form-control">
                                <option value=0 >Created</option>
                                <option value=1 >Payed</option>
                                <option value=2 >Canceled</option>
                                <option value=3 >Removed</option>
                            </select>
                        </div>
                        <div class="col-md-1">
                            <label for="date">Date: </label>
                        </div>
                        <div class="col-md-4">
                            <input type="date" name="date" id="date" v-model="expense.date" class="form-control">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-1">
                            <label for="tags" class="col-form-label">Tags: </label>
                        </div>
                        <div class="form-control col-md-11">
                            <tags class="form-control col-md-11" id="tags" v-model="tag" :tags= "expense.tags" :autocomplete-items="filteredItems"></tags>
                        </div>

                    </div> 
                    <div class="form-group">
                        <label for="description">Description</label>
                        <textarea class="form-control" id="description" rows="3"></textarea>
                    </div>

                </div>
                
                <div class="modal-footer">
                    <div class="col-md-6">
                        <div class="text-left">
                            <button class="modal-default-button" @click="close()">
                                Cancel
                            </button>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="text-right">
                            <button class="modal-default-button" @click="addExp()">
                                Save
                            </button>
                        </div>
                    </div>
                </div>
                
            </div>
        </div>
    </transition>
</template>

<style>
* {
    box-sizing: border-box;
}

.modal-mask {
    position: fixed;
    z-index: 9998;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, .5);
    transition: opacity .3s ease;
}

.modal-container {
    width: 50%;
    margin: 40px auto 0;
    padding: 20px 30px;
    background-color: #fff;
    border-radius: 2px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, .33);
    transition: all .3s ease;
    font-family: Helvetica, Arial, sans-serif;
}

.modal-header h3 {
    margin-top: 0;
    color: #42b983;
}

.modal-body {
    margin: 20px 0;
}

.text-right {
    text-align: right;
}

.text-left {
    text-align: left;
}

label {
    display: block;
    margin-bottom: 1em;
}

label > .form-control {
    margin-top: 0.5em;
}

/* .form-control {
    display: block;
    width: 100%;
    padding: 0.5em 1em;
    line-height: 1.5;
    border: 1px solid #ddd;
} */

/*
 * The following styles are auto-applied to elements with
 * transition="modal" when their visibility is toggled
 * by Vue.js.
 *
 * You can easily play with the modal transition by editing
 * these styles.
 */

.modal-enter {
  opacity: 0;
}

.modal-leave-active {
  opacity: 0;
}

.modal-enter .modal-container,
.modal-leave-active .modal-container {
  -webkit-transform: scale(1.1);
  transform: scale(1.1);
}
</style>

<script>      

import VueTagsInput from '@johmun/vue-tags-input';

export default {
    name: 'modal',
    props: {
        show: Boolean,
        exp: Object,
    },
     data: function () {
         let new_exp = this.exp || {name: 'neww', description: '', value: 0.00, status: 0, date: new Date(), tags:[]}
        return {
            expense: {
                name: new_exp.name,
                description: new_exp.description, 
                value: new_exp.value, 
                status: new_exp.status, 
                date: new_exp.date, 
                tags: new_exp.tags,
            }, 
            user_tags: [],
            tag: '',
        }
    },
    methods: {
        close() {
          console.log('Close...');
            this.$emit('close');
        },
        addExp() {
            this.close();
        },
        userTags(){
            this.$http.get('/tags/')
            .then(result =>{console.log(result.body); this.user_tags = result.body})
            .catch( err => {console.log(err)});
        },
    },

    watch: {
        show: function () {
            console.log('show was changed');
            if (this.show){
                console.log('Show is true');
                this.userTags();
            }
            console.log('Finish watch....')
        }
    },

    mounted() {
        console.log('Mounted...');
        document.addEventListener("keydown", (e) => {
            if (this.show && e.keyCode == 27) {
              this.close();
            }
        });
    },
    computed: {
        filteredItems() {
          return this.user_tags.filter(i => i.text.toLowerCase().includes(this.tag.toLowerCase()));
        }
    },
    components: {
        tags: VueTagsInput,
    }
}
</script>