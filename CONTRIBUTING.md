# Contributing to Conjure Get Started

Thank you for your interest in contributing! This repository provides production-ready templates and bundles for the Conjure community.

## How to Contribute

### Adding a New Template

1. **Create a template directory**
   ```bash
   mkdir -p templates/category/template-name
   ```

2. **Add template.yaml metadata**
   ```yaml
   name: template-name
   description: Brief description of what this template does
   version: 1.0.0

   variables:
     - name: required_var
       description: Description of the variable
       required: true

     - name: optional_var
       description: Description with default
       default: default_value
   ```

3. **Create your template files**
   - Use Conjure template syntax: `{{ .variable_name }}`
   - Include conditionals when appropriate: `{{- if .condition }}`
   - Add loops for repeated elements: `{{- range .items }}`

4. **Add a README**
   - Explain what the template generates
   - Provide usage examples
   - Document all variables
   - Include example values

5. **Test your template**
   ```bash
   conjure template templates/category/template-name -f test-values.yaml
   ```

### Adding a New Bundle

1. **Create a bundle directory**
   ```bash
   mkdir -p bundles/bundle-name
   ```

2. **Create bundle.yaml**
   ```yaml
   name: bundle-name
   description: Complete solution description
   version: 1.0.0

   templates:
     - name: template-instance-name
       template: ../../templates/category/template
       output: path/to/output.yaml
       variables:
         specific_var: value

   variables:
     - name: bundle_var
       description: Variable description
       required: true
   ```

3. **Add a comprehensive README**
   - Explain what gets generated
   - Show file structure
   - Document all variables
   - Provide complete examples

4. **Create example values file**
   - Add to `examples/` directory
   - Name it `bundle-name-values.yaml`
   - Include realistic production values
   - Add comments explaining choices

### Template Best Practices

1. **Variable Naming**
   - Use snake_case for variables
   - Be descriptive: `database_url` not `db`
   - Group related variables with prefixes

2. **Defaults**
   - Provide sensible defaults when possible
   - Use production-safe defaults
   - Document why defaults were chosen

3. **Documentation**
   - Every template needs a README
   - Document all variables with descriptions
   - Provide usage examples
   - Explain common use cases

4. **Conditionals**
   - Use for optional features
   - Keep logic simple and readable
   - Document conditions in README

5. **Testing**
   - Test with minimal required variables
   - Test with all optional variables
   - Test edge cases
   - Verify generated output

### Code Style

- **YAML**: 2-space indentation
- **Templates**: Keep formatting consistent
- **Comments**: Explain non-obvious choices
- **Line length**: Keep under 120 characters when possible

### Examples Directory

When adding examples:

1. Use realistic, production-like values
2. Name files descriptively: `{bundle-name}-{environment}-values.yaml`
3. Add comments explaining configuration choices
4. Test that examples actually work

### Pull Request Process

1. **Fork the repository**

2. **Create a feature branch**
   ```bash
   git checkout -b feature/add-xyz-template
   ```

3. **Make your changes**
   - Follow the guidelines above
   - Test thoroughly
   - Update documentation

4. **Commit with clear messages**
   ```bash
   git commit -m "Add XYZ template for ABC use case"
   ```

5. **Push to your fork**
   ```bash
   git push origin feature/add-xyz-template
   ```

6. **Open a Pull Request**
   - Describe what you're adding
   - Explain the use case
   - Include example usage
   - Reference any related issues

### What We Look For

- **Utility**: Does it solve a real-world problem?
- **Quality**: Is it production-ready?
- **Documentation**: Can users understand how to use it?
- **Testing**: Have you verified it works?
- **Consistency**: Does it follow existing patterns?

## Questions?

- Open an issue for discussions
- Check existing templates for examples
- Ask in pull request comments

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
