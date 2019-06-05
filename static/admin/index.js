// @ts-nocheck
var DocumentPreview = createClass({
  render: function() {
    var entry = this.props.entry;
    var title = entry.getIn(["data", "name"]);
    var link = entry.getIn(["data", "external_url"], null);
    var acronym = entry.getIn(["data", "acronym"], null);
    var TSC = entry.getIn(["data", "satisfies", "TSC 2017"], []);
    var hLink = function(href, text, variable = true) {
      return variable ? h("a", { href, target: "_blank" }, text) : "N/A";
    }
    return h(
      "div",
      {},
      h("dl", {},
        h("dt", {}, "Title"),
        h("dd", {}, title),
        h("dt", {}, "PDF Link"),
        h("dd", {}, hLink("/documents/Sample-"+acronym+".pdf", "PDF", acronym)),
        h("dt", {}, "External URL"),
        h("dd", {}, hLink(link, "Link", link)),
        h("dt", {}, "Criteria"),
        h("dd", {}, h("ul", {},
          TSC.map(criterium => h("li", {key: criterium}, h("a", {href: "/#standards-"+criterium, target: "_blank"}, criterium))))
        )
      ),
      h("hr", {}, null),
      h("div", { className: "latex-container" }, h("div", { className: "latex" }, this.props.widgetFor("body")))
    );
  }
});
var SelectControl = CMS.getWidget("select").control
var SatisfiesControl = createClass({
  getInitialState: function() {
    return {
      options: Immutable.fromJS([]),
    };
  },
  componentDidMount: function() {
    this.props.loadEntry("standards", this.props.field.get("name")).then(({payload}) => {
      var data = payload.entry.data
      delete data.name
      var options = Object.entries(data).map(entry => ({ label: `[${entry[0]}] ${entry[1].name} - ${entry[1].description}`, value: entry[0] }))
      this.setState({
        options: Immutable.fromJS(options)
      })
    })
  },
  render: function() {
    var newField = this.props.field.set("options", this.state.options).set("multiple", true)
    var newProps = Object.assign({}, this.props, {field: newField})
    return (new SelectControl(newProps)).render();
  }
});

const image = {
  label: 'Image',
  id: 'image',
  fields: [
    {
      label: 'Image',
      name: 'image',
      widget: 'image',
      media_library: {
        allow_multiple: false,
      },
    },
    {
      label: 'Title',
      name: 'title',
    },
  ],
  fromBlock: match =>
    match && {
      image: match[2],
      title: match[1],
    },
  toBlock: ({ title, image }) =>
    `![${title || ''}](${image || ''})`,
  toPreview: ({ image, title }, getAsset) => (
    h("img", {
      src: getAsset(image) || '',
      alt: title || '',
      title: title || ''
    })
  ),
  pattern: /^!\[(.*)\]\((.*?)(\s"(.*)")?\)$/
};

CMS.registerEditorComponent(image);
CMS.registerPreviewStyle("document-preview.css");
CMS.registerWidget('satisfies', SatisfiesControl);
CMS.registerPreviewTemplate("policies", DocumentPreview);
CMS.registerPreviewTemplate("narratives", DocumentPreview);